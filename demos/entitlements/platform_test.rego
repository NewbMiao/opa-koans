package entitlements_test

import data.entitlements.platforms
import data.rules

test_platforms_empty {
	[] = platforms with input as {}
}

test_platforms_oldPlatform {
	[] = platforms with input as {
		"version": "1",
		"sub_version": "0",
		"money_available": 100,
	}
}

test_platforms_both {
	["oldPlatform", "newPlatform"] = platforms with input as {"product": {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}}
}

test_platforms_newPlatform {
	["newPlatform"] = platforms with input as {"product": {
		"version": "1",
		"sub_version": "3",
		"money_available": 100,
	}}
}
