package UnitTests.Pedal_Control;

import assertLib.Assert;
import System.Percentage;

import System.Pedal_Control.PedalCalc;

static class PedalCalc_UT{
	PedalCalc unitUnderTest;
	
	@Test
	public void lowerStart()
	{
		//Testing around lower tolerance of StartValue
		// StartValue-Tolerance = lowest Value before Error
		Percentage perc;
		//startVal_TL 	= 10.0
		//startVal_TH 	= 10.0
		//endVal_TL		= 10.0
		//endVal_TH 	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//rawInput		= 10.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(10.0, 10.0, 10.0, 10.0, 20.0, 140.0, 10.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//startVal_TL 	= 10.0
		//startVal_TH 	= 10.0
		//endVal_TL		= 10.0
		//endVal_TH 	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//rawInput		= 9.99
		//getPercentage should give 0 percent and error
		perc = unitUnderTest.getPercentage(10.0, 10.0, 10.0, 10.0, 20.0, 140.0, 9.99);
		Assert.assertEqual(perc, 0.0);
		Assert.assertTrue(unitUnderTest.hasError());
	}
	
	@Test
	public void higherStart()
	{
		//Testing around higher tolerance of StartValue
		// StartValue+Tolerance = highest Value before accepted
		Percentage perc;
		//startVal_TL 	= 10.0
		//startVal_TH 	= 10.0
		//endVal_TL		= 10.0
		//endVal_TH 	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//rawInput		= 30.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(10.0, 10.0, 10.0, 10.0, 20.0, 140.0, 30.0);
		Assert.assertEqual(perc, 0.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//startVal_TL 	= 10.0
		//startVal_TH 	= 10.0
		//endVal_TL		= 10.0
		//endVal_TH 	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//rawInput		= 35.0
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(10.0, 10.0, 10.0, 10.0, 20.0, 140.0,  35.0);
		Assert.assertFloatEqual(perc, 5.0);
		Assert.assertFalse(unitUnderTest.hasError());
	}
	
	
	@Test
	public void lowerEnd()
	{
		//Testing around lower tolerance of EndValue
		// EndValue+-Tolerance = highest Value 
		Percentage perc;
		//startVal_TL 	= 10.0
		//startVal_TH 	= 10.0
		//endVal_TL		= 10.0
		//endVal_TH 	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//rawInput		= 130.0
		//getPercentage should give 100 percent and no error
		perc = unitUnderTest.getPercentage(10.0, 10.0, 10.0, 10.0, 20.0, 140.0, 130.0);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//startVal_TL 	= 10.0
		//startVal_TH 	= 10.0
		//endVal_TL		= 10.0
		//endVal_TH 	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//rawInput		= 130.1
		//getPercentage should give 100 percent and no error
		perc = unitUnderTest.getPercentage(10.0, 10.0, 10.0, 10.0, 20.0, 140.0, 130.1);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
	}
	
	@Test
	public void higherEnd()
	{
		//Testing around higher tolerance of StartValue
		// EndValue+Tolerance = highest Value before error
		Percentage perc;
		//startVal_TL 	= 10.0
		//startVal_TH 	= 10.0
		//endVal_TL		= 10.0
		//endVal_TH 	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//rawInput		= 150.0
		//getPercentage should give 100 percent and no error
		perc = unitUnderTest.getPercentage(10.0, 10.0, 10.0, 10.0, 20.0, 140.0, 150.0);
		Assert.assertEqual(perc, 100.0);
		Assert.assertFalse(unitUnderTest.hasError());
		
		//startVal_TL 	= 10.0813
		//startVal_TH 	= 10.0
		//endVal_TL		= 10.0
		//endVal_TH 	= 10.0
		//startVal		= 20.0
		//endVal  		= 140.0
		//rawInput		= 150.01
		//getPercentage should give 0 percent and no error
		perc = unitUnderTest.getPercentage(10.0, 10.0, 10.0, 10.0, 20.0, 140.0, 150.01);
		Assert.assertFloatEqual(perc, 0.0);
		Assert.assertTrue(unitUnderTest.hasError());
	}
	
}