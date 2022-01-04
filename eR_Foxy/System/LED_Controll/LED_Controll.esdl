package System.LED_Controll;
import SystemLib.Miscellaneous.DeltaTimeService;

class LED_Controll {
	@set
	private LED_Mode mode;
	boolean LED;
	real timer;
	characteristic real LED_On_Time = 1.0;
	characteristic real LED_Off_Time = 1.0;

	@generated("statemachine", "000000")
	public void lED_ControllStatemachineTrigger() triggers LED_ControllStatemachine;

	@generated("statemachine", "96782021")
	statemachine LED_ControllStatemachine using LED_ControllStatemachineStates {
		start OFF;

		state OFF {
			entry {
				LED = false;
			}
			transition mode == LED_Mode.on to ON;
			transition mode == LED_Mode.blinking to BLINK;
		}

		state ON {
			entry {
				LED = true;
			}
			transition mode == LED_Mode.off to OFF;
			transition mode == LED_Mode.blinking to BLINK;
		}

		state BLINK {
			transition mode == LED_Mode.on to ON;
			transition mode == LED_Mode.off to OFF;
			start BlinkOn;

			state BlinkOff {
				entry {
					LED = false;
				}
				static {
					timer = timer + DeltaTimeService.deltaT;
				}
				exit {
					timer = 0.0;
				}
				transition timer >= LED_Off_Time to BlinkOn;
			}

			state BlinkOn {
				entry {
					LED = true;
				}
				static {
					timer = timer + DeltaTimeService.deltaT;
				}
				exit {
					timer = 0.0;
				}
				transition timer >= LED_On_Time to BlinkOff;
			}
		}
	}
}
@generated("statemachine", "000000")
type LED_ControllStatemachineStates is enum {
	OFF,
	ON,
	BLINK,
	BlinkOff,
	BlinkOn
};