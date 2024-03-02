package entitlements_test

import rego.v1

import data.entitlements.platforms
import data.rules.platforms as platforms_rules
import input.product as dataProduct

rules := {"oldPlatform": {"product": {"fullVersion": ["1.0", "1.1", "1.2"]}}, "newPlatform": {"product": {"fullVersion": ["1.2", "1.3"]}}}

test_platforms_empty if {
	[] = platforms with dataProduct as {}
}

test_platforms_old if {
	["oldPlatform"] = platforms with dataProduct as {
		"version": "1",
		"sub_version": "0",
		"money_available": 100,
	}
		with platforms_rules as rules
}

test_platforms_both if {
	["oldPlatform", "newPlatform"] = platforms with dataProduct as {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}
		with platforms_rules as rules
}

test_platforms_new if {
	["newPlatform"] = platforms with dataProduct as {
		"version": "1",
		"sub_version": "3",
		"money_available": 100,
	}
		with platforms_rules as rules
}
