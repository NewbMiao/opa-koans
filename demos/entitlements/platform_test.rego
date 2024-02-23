package entitlements_test

import data.entitlements.platforms
import data.rules
import data.users["001"].product as dataProduct

test_platforms_empty {
	[] = platforms with dataProduct as {} with input.userId as "001"
}

test_platforms_old {
	["oldPlatform"] = platforms with dataProduct as {
		"version": "1",
		"sub_version": "0",
		"money_available": 100,
	}
		with input.userId as "001"
}

test_platforms_both {
	["oldPlatform", "newPlatform"] = platforms with dataProduct as {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}
		with input.userId as "001"
}

test_platforms_new {
	["newPlatform"] = platforms with dataProduct as {
		"version": "1",
		"sub_version": "3",
		"money_available": 100,
	}
		with input.userId as "001"
}
