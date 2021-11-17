package UnitTests.Pedal_Control.Throttle;

import assertLib.Assert;
import System.Percentage;

import System.Pedal_Control.Throttle.Throttle_MDL;

static class Throttle_UT{
	Throttle_MDL unitUnderTest = Throttle_MDL.startTolerance10();
	//All tolerances set to 10 for testing purpose
	
	@Test
	public void lowerStart()
	{
		//Testing around lower tolerance of StartValue
		// StartValue-Tolerance = lowest Value before Error
		Percentage perc;
		//rawInput_1	= 10.0
		//rawInput_2	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(10.0,10.0,20.0,140.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//rawInput_1	= 9.99
		//rawInput_2	= 9.99
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(9.99,9.99,20.0,140.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertTrue(unitUnderTest.hasError());
	}
	
	@Test
	public void higherStart()
	{
		//Testing around higher tolerance of StartValue
		// StartValue+Tolerance = highest Value before accepted
		Percentage perc;
		//rawInput_1	= 30.0
		//rawInput_2	= 30.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(30.0,30.0,20.0,140.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//rawInput_1	= 35.0
		//rawInput_2	= 35.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(35.0,35.0,20.0,140.0);
		Assert.assertFloatEqual(perc, 5.0);
		Assert.assertFalse(unitUnderTest.hasError());
	}
	
	
	@Test
	public void lowerEnd()
	{
		//Testing around lower tolerance of EndValue
		// EndValue+-Tolerance = highest Value 
		Percentage perc;
		//rawInput_1	= 130.0
		//rawInput_2	= 130.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(130.0,130.0,20.0,140.0);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//rawInput_1	= 130.1
		//rawInput_2	= 130.1
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(130.1,130.1,20.0,140.0);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
	}
	
	@Test
	public void higherEnd()
	{
		//Testing around higher tolerance of StartValue
		// EndValue+Tolerance = highest Value before error
		Percentage perc;
		//rawInput_1	= 150.0
		//rawInput_2	= 150.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(150.0,150.0,20.0,140.0);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//rawInput_1	= 150.1
		//rawInput_2	= 150.1
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(150.1,150.1,20.0,140.0);
		Assert.assertFloatEqual(perc, 0.0);
		Assert.assertTrue(unitUnderTest.hasError());
	}
	
	
	@Test
	public void implauibilityTest_CorrectCase()
	{
		//Testing for implausibility
		//Values are not allowed to differ more than 10%
		Percentage perc;
		//rawInput_1	= 80.0
		//rawInput_2	= 80.0
		//80/80 = 1 --> 0% difference
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(80.0,80.0,20.0,140.0);
		Assert.assertEqual(perc, 50.0);
		Assert.assertFalse(unitUnderTest.hasError());
		//Testing for implausibility
		//Values are not allowed to differ more than 10%
		
	}
	
	@Test
	public void implauibilityTest_CorrectCase2()
	{
		//Testing for implausibility
		//Values are not allowed to differ more than 10%
		Percentage perc;
		
		//rawInput_1	= 80.0
		//rawInput_2	= 75.85
		//startVal		= 20.0
		//50/45.85 = 1.09 --> 9% difference   (Startvalue and Tolerance need to be substracted)
		//45.85/50 = 0.917  --> 8.3% difference
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(80.0,75.85,20.0,140.0);
		Assert.assertFloatEqual(perc, 47.925);
		Assert.assertFalse(unitUnderTest.hasError());
	}
	
	@Test
	public void implauibilityTest_80_70()
	{
		//Testing for implausibility
		//Values are not allowed to differ more than 10%
		Percentage perc;
	
		
		//rawInput_1	= 80.0
		//rawInput_2	= 70.0
		//50/40 = 1.25 --> 25% difference
		//startVal		= 20.0
		//endVal  		= 140.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(80.0,70.0,20.0,140.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertTrue(unitUnderTest.hasError());
		
	}
	
	
	
}