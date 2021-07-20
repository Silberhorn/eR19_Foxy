package System.Pedal_Control;
import System.Percentage;

class PedalCalc {
	real tolerance_startLow = 0.0;
	real tolerance_startHigh = 0.0;
	real tolerance_endLow = 0.0;
	real tolerance_endHigh = 0.0;
	real tsLow = 0.0;
	real tsHigh = 0.0;
	real teLow = 0.0;
	real teHigh = 0.0;
	boolean reachedStart = false;
	boolean hasErrorVal = false;
	real br_perc = 0.0;
	boolean reachedEndLow = false;
	real returnValue = 0.0;
	sysconst real c = 1.0;
	const real c_2 = 0.0;
	const real c_3 = 100.0;
	boolean reachedEndHigh;

	@generated("blockdiagram", "70ff9ae3")
	public Percentage getPercentage(real in startVal_TL, real in startVal_TH, real in endVal_TL, real in endVal_TH, real in startVal, real in endVal, real in rawInput) {
		teLow = abs(endVal_TL); // Main/getPercentage 1
		tsHigh = abs(startVal_TH); // Main/getPercentage 2
		tsLow = abs(startVal_TL); // Main/getPercentage 3
		teHigh = abs(endVal_TH); // Main/getPercentage 4
		reachedStart = (rawInput > (startVal + tsHigh)); // Main/getPercentage 5
		hasErrorVal = (((rawInput < (startVal - tsLow)) || (startVal >= endVal)) || (rawInput > (teHigh + endVal))); // Main/getPercentage 6
		br_perc = ((rawInput - (startVal + tsHigh)) / ((endVal - teLow) - (startVal + tsHigh))); // Main/getPercentage 7
		reachedEndLow = (rawInput > (endVal - teLow)); // Main/getPercentage 8
		reachedEndHigh = (rawInput > (teHigh + endVal)); // Main/getPercentage 9
		returnValue = br_perc; // Main/getPercentage 10
		if (!reachedStart) {
			returnValue = 0.0; // Main/getPercentage 11/if-then 1
		} // Main/getPercentage 11
		if (reachedEndLow) {
			returnValue = 1.0; // Main/getPercentage 12/if-then 1
		} // Main/getPercentage 12
		if (reachedEndHigh) {
			returnValue = 0.0; // Main/getPercentage 13/if-then 1
		} // Main/getPercentage 13
		return(returnValue * c_3); // Main/getPercentage 14
	}

	@generated("blockdiagram", "27837fe4")
	public boolean hasError() {
		return hasErrorVal; // Main/hasError 1
	}
}