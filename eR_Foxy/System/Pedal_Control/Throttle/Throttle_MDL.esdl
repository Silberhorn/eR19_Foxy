package System.Pedal_Control.Throttle;

class Throttle_MDL {
	@set
	@get
	real tolerance_startLow = 0.0;
	@set
	@get
	real tolerance_endHigh = 0.0;
	@set
	@get
	real tolerance_endLow = 0.0;
	@set
	@get
	real tolerance_startHigh = 0.0;
	real tsLow = 0.0;
	real tsHigh = 0.0;
	real teLow = 0.0;
	real teHigh = 0.0;
	boolean reachedStart = false;
	boolean notReachedEnd = false;
	real br_perc = 0.0;
	real returnValue = 0.0;
	boolean hasErrorVal = false;

	@generated("blockdiagram", "723a91ba")
	public void calc(real in StartValue, real in EndValue, real in RawInput) {
		tsLow = abs(tolerance_startLow); // Main/calc 1
		teHigh = abs(tolerance_endHigh); // Main/calc 2
		tsHigh = abs(tolerance_startHigh); // Main/calc 3
		teLow = abs(tolerance_endLow); // Main/calc 4
		if (reachedStart && notReachedEnd) {
			returnValue = br_perc; // Main/calc 5/if-then 1
		} else {
			returnValue = 0.0; // Main/calc 5/if-else 1
		} // Main/calc 5
		br_perc = (RawInput / (EndValue - teLow)); // Main/calc 6
		hasErrorVal = ((RawInput < (StartValue - tsLow)) || (RawInput > (teHigh + EndValue))); // Main/calc 7
		notReachedEnd = (RawInput < (EndValue - teLow)); // Main/calc 8
		reachedStart = (RawInput > (StartValue + tsHigh)); // Main/calc 9
	}
}