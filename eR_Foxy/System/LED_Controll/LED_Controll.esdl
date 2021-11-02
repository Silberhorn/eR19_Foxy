package System.LED_Controll;

static class LED_Controll {
	real timeThres;
	real timeInteg;
	@set
	@get
	LED_Mode Mode;
	const LED_Mode led_off = LED_Mode.off;
	const LED_Mode led_on = LED_Mode.on;
	const LED_Mode led_blink = LED_Mode.blinking;
	const boolean c = true;
	@set
	real Frequency;
	const real DEF_1 = 1.0;
	const LED_Mode off = LED_Mode.off;
	boolean State;
	const LED_Mode on = LED_Mode.on;
	const LED_Mode blink = LED_Mode.blinking;
	@dT
	public static real deltaT = 0.0;

	@generated("blockdiagram", "b93d74f1")
	public boolean getState() {
		timeInteg = (deltaT + timeInteg); // Main/getState 1
		timeThres = (DEF_1 / Frequency); // Main/getState 2
		if (Mode == off) {
			State = false; // Main/getState 3/if-then 1
		} // Main/getState 3
		if (Mode == on) {
			State = true; // Main/getState 4/if-then 1
		} // Main/getState 4
		if (Mode == blink) {
			if (timeInteg >= timeThres) {
				if (State) {
					State = false; // Main/getState 5/if-then 1/if-then 1/if-then 1
				} else {
					State = true; // Main/getState 5/if-then 1/if-then 1/if-else 1
				} // Main/getState 5/if-then 1/if-then 1
				timeInteg = 0.0; // Main/getState 5/if-then 1/if-then 2
			} // Main/getState 5/if-then 1
		} // Main/getState 5
		return State; // Main/getState 6
	}
}