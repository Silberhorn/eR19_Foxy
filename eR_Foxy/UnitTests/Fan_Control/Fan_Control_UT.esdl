package UnitTests.Fan_Control;

import assertLib.Assert;
import System.Percentage;
import System.Fan_Control.FanControll;

static class Fan_Control_UT{
	FanControll unitTest;
	
	@Test
	public void belowMinimum()
	{
		Assert.assertEqual(unitTest.fanSpeed(-40.0), 0.0);
	}
	@Test
	public void atMinimum()
	{
		Assert.assertEqual(unitTest.fanSpeed(-30.0), 0.0);
	}
	@Test
	public void belowMaximum()
	{
		Assert.assertLessThan(unitTest.fanSpeed(49.0), 100.0);
	}
	@Test
	public void atMaximumNoHeur()
	{
		Assert.assertEqual(unitTest.fanSpeed(50.0), 100.0);
	}
	@Test
	public void aboveMaximum()
	{
		Assert.assertEqual(unitTest.fanSpeed(60.0), 100.0);
	}
	@Test
	public void belowMaximumWithHeur()
	{
		unitTest.fanSpeed(70.0);
		unitTest.fanSpeed(80.0);
		Assert.assertEqual(unitTest.fanSpeed(49.0), 100.0);
	}
	@Test
	public void belowMaximumNoMoreHeur()
	{
		unitTest.fanSpeed(70.0);
		unitTest.fanSpeed(80.0);
		//Heuristic active
		unitTest.fanSpeed(0.89*50.0);
		//Heuristic not active (set to 90% of Max val)
		
		Assert.assertLessThan(unitTest.fanSpeed(49.0), 100.0);
	}
}

