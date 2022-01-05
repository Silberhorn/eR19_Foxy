package System.LED_Controll;
import SystemLib.Miscellaneous.DeltaTimeService;

class LED_Controll {
	private LED_Mode mode = LED_Mode.off;
	boolean LED = false;
	real timer = 0.0;
	private real frequency = 10000.0;
	real LED_On_Time = 0.0;
	real LED_Off_Time = 0.0;

	public LED_Mode getMode()
	{
		return mode;
	}
	
	public boolean getLED()
	{
		return LED;
	}

	public void setFrequency(real x)
	{
		frequency = x;
	}

	public void setMode(LED_Mode x)
	{
		mode = x;
	}



	@generated("statemachine", "000000")
	public void lED_ControllStatemachineTrigger() triggers LED_ControllStatemachine;

	@generated("statemachine", "466c1e16")
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
					LED_Off_Time = 1.0 / frequency;
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
					LED_On_Time = 1.0 / frequency;
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