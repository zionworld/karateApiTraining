package com.api.automation.getFeature;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestGetRunner {

	@Test
	public Karate runTest() {
		return Karate.run("getRequest").relativeTo(getClass());
	}
	
	//@Test
	public Karate runTestWithClassPath() {
		return Karate.run("classpath:/getFeature/getRequest.feature");
	}
}
