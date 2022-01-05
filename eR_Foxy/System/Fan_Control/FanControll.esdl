package System.Fan_Control;
import System.Percentage;

class FanControll {
	characteristic real temp_low = -30.0;
	characteristic real temp_high = 50.0;
	real temp_range;
	real temp_high_heuristic;
	characteristic real temp_high_heur_fact = 0.9;
	real returnVal;
	boolean toggleHeuristicHigh;

	@generated("blockdiagram", "619070cc")
	public Percentage fanSpeed(real in currTemp) {
		temp_range = abs((temp_low - temp_high)); // Main/fanSpeed 1
		temp_high_heuristic = (temp_high * temp_high_heur_fact); // Main/fanSpeed 2
		if (currTemp >= temp_high) {
			toggleHeuristicHigh = true; // Main/fanSpeed 3/if-then 1
		} // Main/fanSpeed 3
		if (currTemp <= temp_high_heuristic) {
			toggleHeuristicHigh = false; // Main/fanSpeed 4/if-then 1
		} // Main/fanSpeed 4
		if (toggleHeuristicHigh) {
			returnVal = 100.0; // Main/fanSpeed 5/if-then 1
		} else {
			returnVal = ((min((currTemp - temp_low), 0.0) / temp_range) * 100.0); // Main/fanSpeed 5/if-else 1
		} // Main/fanSpeed 5
		return returnVal; // Main/fanSpeed 6
	}
}