package System.Pedal_Control.Throttle;
import System.Pedal_Control.PedalCalc;
import System.Percentage;

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
	PedalCalc PedalCalc_Throttle_01;
	PedalCalc PedalCalc_Throttle_02;
	sysconst real Throttle_2_DEF = 2.0;
	const real percent_90 = 0.9;
	sysconst real percent_110 = 1.1;
	boolean inplausabilityError;
	boolean sensorError;
	Percentage perc_01;
	Percentage perc_02;
	characteristic real zeroCompare = 10.0;
	boolean implausibleAroundZero;
	boolean percIsZero;
	real returnVal;

	@generated("blockdiagram", "259ee21b")
	public Percentage getPercentage(real in rawInput_Sens01, real in rawInput_Sens02, real in StartValue, real in EndValue) {
		perc_01 = PedalCalc_Throttle_01.getPercentage(tolerance_startLow, tolerance_startHigh, tolerance_endLow, tolerance_endHigh, StartValue, EndValue, rawInput_Sens01); // Main/getPercentage 1
		perc_02 = PedalCalc_Throttle_02.getPercentage(tolerance_startLow, tolerance_startHigh, tolerance_endLow, tolerance_endHigh, StartValue, EndValue, rawInput_Sens02); // Main/getPercentage 2
		sensorError = (PedalCalc_Throttle_01.hasError() || PedalCalc_Throttle_02.hasError()); // Main/getPercentage 3
		percIsZero = ((perc_01 == 0.0) || (perc_02 == 0.0)); // Main/getPercentage 4
		if (perc_01 == 0.0) {
			if (perc_02 <= zeroCompare) {
				implausibleAroundZero = false; // Main/getPercentage 5/if-then 1/if-then 1
			} // Main/getPercentage 5/if-then 1
		} // Main/getPercentage 5
		if (perc_02 == 0.0) {
			if (perc_01 <= zeroCompare) {
				implausibleAroundZero = false; // Main/getPercentage 6/if-then 1/if-then 1
			} // Main/getPercentage 6/if-then 1
		} // Main/getPercentage 6
		if (percIsZero) {
			inplausabilityError = implausibleAroundZero; // Main/getPercentage 7/if-then 1
		} else {
			inplausabilityError = (((((perc_01 / perc_02) < percent_90) || ((perc_02 / perc_01) < percent_90)) || ((perc_01 / perc_02) > percent_110)) || ((perc_02 / perc_01) > percent_110)); // Main/getPercentage 7/if-else 1
		} // Main/getPercentage 7
		if (sensorError || inplausabilityError) {
			returnVal = 0.0; // Main/getPercentage 8/if-then 1
		} else {
			returnVal = ((perc_01 + perc_02) / Throttle_2_DEF); // Main/getPercentage 8/if-else 1
		} // Main/getPercentage 8
		return returnVal; // Main/getPercentage 9
	}

	@generated("blockdiagram", "35baee4c")
	public boolean hasError() {
		return(sensorError || inplausabilityError); // Main/hasError 1
	}

	public initializer startTolerance10() {
		tolerance_startLow = 10.0;
		tolerance_endHigh = 10.0;
		tolerance_endLow = 10.0;
		tolerance_startHigh = 10.0;
		inplausabilityError = false;
		sensorError = false;
	}
}