package System.Pedal_Control.Brake;
import System.Percentage;
import System.Pedal_Control.PedalCalc;

class Brake_MDL {
	@set
	@get
	real tolerance_endHigh = 0.0;
	@set
	@get
	real tolerance_startHigh = 0.0;
	@set
	@get
	real tolerance_endLow = 0.0;
	@set
	@get
	real tolerance_startLow = 0.0;
	PedalCalc PedalCalc_instance;

	@generated("blockdiagram", "8afb2fcd")
	public Percentage getPercentage(real in rawInput, real in startValue, real in endValue) {
		return PedalCalc_instance.getPercentage(tolerance_startLow, tolerance_startHigh, tolerance_endLow, tolerance_endHigh, startValue, endValue, rawInput); // Main/getPercentage 1
	}

	@generated("blockdiagram", "25e30446")
	public boolean hasError() {
		return PedalCalc_instance.hasError(); // Main/hasError 1
	}

	public initializer startTolerance10() {
		tolerance_endHigh = 10.0;
		tolerance_startHigh = 10.0;
		tolerance_endLow = 10.0;
		tolerance_startLow = 10.0;
	}
}