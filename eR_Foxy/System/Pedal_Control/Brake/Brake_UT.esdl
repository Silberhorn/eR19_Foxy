package System.Pedal_Control.Brake;

import assertLib.Assert;
import System.Pedal_Control.Brake.Brake_MDL;

static class Brake_UT {
	Brake_MDL unitUnderTest = Brake_MDL.startAt0();
	
	public void testInitialValues(){
		Assert.assertEqual(unitUnderTest.getPercentage(), 0.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		}
		
	public void calcTest(){
		unitUnderTest.calc(2.0, 5.0, 3.5);
		Assert.assertEqual(unitUnderTest.getPercentage(), 50.0);
		}
	
}