package System.LED_Controll;

class LED_Controll_Main {
	LED_Controll LED_Controll_instance;
	characteristic LED_Mode testvar = LED_Mode.off;

	@generated("blockdiagram", "0f71c02d")
	public void calc() {
		LED_Controll_instance.lED_ControllStatemachineTrigger(); // Main/calc 1
		LED_Controll_instance.mode = testvar; // Main/calc 2
	}
}