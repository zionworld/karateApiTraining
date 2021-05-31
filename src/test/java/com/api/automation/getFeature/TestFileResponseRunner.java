package com.api.automation.getFeature;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestFileResponseRunner {

	@Test
	public Karate run() {
		return Karate.run("fileResponseValidation").relativeTo(getClass());
	}
}
