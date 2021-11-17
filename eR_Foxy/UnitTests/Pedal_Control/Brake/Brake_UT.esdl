package UnitTests.Pedal_Control.Brake;
import assertLib.Assert;
import System.Percentage;

import System.Pedal_Control.Brake.Brake_MDL;

static class Brake_UT{
	Brake_MDL unitUnderTest = Brake_MDL.startTolerance10();
	//All tolerances set to 10 for testing purpose
	
	@Test
	public void lowerStart()
	{
		//Testing around lower tolerance of StartValue
		// StartValue-Tolerance = lowest Value before Error
		Percentage perc;
		//rawInput		= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(10.0,20.0,140.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//rawInput		= 9.99
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and error
		perc = unitUnderTest.getPercentage(9.99,20.0,140.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertTrue(unitUnderTest.hasError());
	}
	
	@Test
	public void higherStart()
	{
		//Testing around higher tolerance of StartValue
		// StartValue+Tolerance = highest Value before accepted
		Percentage perc;
		//rawInput		= 30.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(30.0,20.0,140.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//rawInput		= 35.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(35.0,20.0,140.0);
		Assert.assertFloatEqual(perc, 5.0);
		Assert.assertFalse(unitUnderTest.hasError());
	}
	
	
	@Test
	public void lowerEnd()
	{
		//Testing around lower tolerance of EndValue
		// EndValue+-Tolerance = highest Value 
		Percentage perc;
		//rawInput		= 130.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 100 percent and no error
		perc = unitUnderTest.getPercentage(130.0,20.0,140.0);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//rawInput		= 130.1
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 100 percent and no error
		perc = unitUnderTest.getPercentage(130.1,20.0,140.0);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
	}
	
	@Test
	public void higherEnd()
	{
		//Testing around higher tolerance of StartValue
		// EndValue+Tolerance = highest Value before error
		Percentage perc;
		//rawInput		= 150.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 100 percent and no error
		perc = unitUnderTest.getPercentage(150.0,20.0,140.0);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//rawInput		= 150.1
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(150.1,20.0,140.0);
		Assert.assertFloatEqual(perc, 0.0);
		Assert.assertTrue(unitUnderTest.hasError());
	}
	
}