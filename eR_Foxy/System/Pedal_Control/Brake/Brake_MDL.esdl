package System.Pedal_Control.Brake;
import System.Percentage;

class Brake_MDL {
	real br_perc = 0.0;
	boolean reachedStart = false;
	real returnValue = 0.0;
	boolean hasErrorVal = false;
	boolean notReachedEnd = false;
	@set
	@get
	real tolerance_startLow = 0.0;
	@set
	@get
	real tolerance_startHigh = 0.0;
	@set
	@get
	real tolerance_endLow = 0.0;
	@set
	@get
	real tolerance_endHigh = 0.0;
	real tsLow = 0.0;
	real tsHigh = 0.0;
	real teLow = 0.0;
	real teHigh = 0.0;

	@generated("blockdiagram", "6c5d10fd")
	public void calc(real in StartVlue, real in EndValue, real in RawInput) {
		reachedStart = (RawInput > (StartVlue + tsHigh)); // Main/calc 1
		hasErrorVal = ((RawInput < (StartVlue - tsLow)) || (RawInput > (teHigh + EndValue))); // Main/calc 2
		if (reachedStart && notReachedEnd) {
			returnValue = br_perc; // Main/calc 3/if-then 1
		} else {
			returnValue = 0.0; // Main/calc 3/if-else 1
		} // Main/calc 3
		br_perc = (RawInput / (EndValue - teLow)); // Main/calc 4
		notReachedEnd = (RawInput < (EndValue - teLow)); // Main/calc 5
		tsLow = abs(tolerance_startLow); // Main/calc 6
		tsHigh = abs(tolerance_startHigh); // Main/calc 7
		teLow = abs(tolerance_endLow); // Main/calc 8
		teHigh = abs(tolerance_endHigh); // Main/calc 9
	}

	@generated("blockdiagram", "2265db27")
	public Percentage getPercentage() {
		return returnValue; // Main/getPercentage 1
	}

	@generated("blockdiagram", "f5415222")
	public boolean hasError() {
		return hasErrorVal; // Main/hasError 1
	}

	public initializer startAt0() {

		br_perc = 0.0;

		reachedStart = false;
		returnValue = 0.0;
		hasErrorVal = false;
		notReachedEnd = false;
		teLow = 0.0;
		tsHigh = 0.0;
		tsLow = 0.0;
		tolerance_endHigh = 0.0;
		tolerance_endLow = 0.0;
		tolerance_startHigh = 0.0;
		tolerance_startLow = 0.0;
		teHigh = 0.0;
	}
}