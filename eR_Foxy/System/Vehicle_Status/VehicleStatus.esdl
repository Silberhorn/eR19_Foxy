package System.Vehicle_Status;
import System.Percentage;
import SystemLib.Miscellaneous.DeltaTimeService;

class VehicleStatus {
	@set
	private boolean TSMS;
	@set
	private boolean ShutdownCircuit;
	@set
	private boolean StartButton;
	@set
	private Percentage BrakePedal;
	@set
	private real ThrottlePedal;
	real timer;
	boolean HVActive_to_ReadyToDrive;
	boolean Error_to_LVActive;

	@generated("statemachine", "000000")
	public void vehicleStatusStatemachineTrigger() triggers VehicleStatusStatemachine;

	@generated("statemachine", "4d7dbb87")
	statemachine VehicleStatusStatemachine using VehicleStatusStatemachineStates {
		start LVActive;

		state LVActive {
			transition ShutdownCircuit == false to Error;
			transition TSMS == true to HVActive;
		}

		state Error {
			entry {
				timer = 0.0;
				Error_to_LVActive = false;
			}
			static {
				if (StartButton) {
					timer = timer + DeltaTimeService.deltaT;
					Error_to_LVActive = timer >= 1.0;
				} else {
					timer = 0.0;
				}
			}
			transition true to LVActive;
		}

		state HVActive {
			entry {
				timer = 0.0;
				HVActive_to_ReadyToDrive = false;
			}
			static {
				if (BrakePedal > 10.0 && StartButton) {
					timer = timer + DeltaTimeService.deltaT;
					HVActive_to_ReadyToDrive = timer >= 1.0;
				} else {
					timer = 0.0;
				}
			}
			transition ShutdownCircuit == false to Error;
			transition ShutdownCircuit == true && TSMS == false to LVActive;
			transition HVActive_to_ReadyToDrive to ReadyToDrive;
		}

		state ReadyToDrive {
			transition ShutdownCircuit == false to Error;
			transition BrakePedal > 10.0 && ThrottlePedal > 25.0 to ZeroTorque;
			transition ShutdownCircuit == true && TSMS == false to LVActive;
		}

		state ZeroTorque {
			transition ShutdownCircuit == false to Error;
			transition ShutdownCircuit == true && TSMS == false to LVActive;
			transition ThrottlePedal < 5.0 to ReadyToDrive;
		}
	}
}
@generated("statemachine", "000000")
type VehicleStatusStatemachineStates is enum {
	LVActive,
	Error,
	HVActive,
	ReadyToDrive,
	ZeroTorque
};