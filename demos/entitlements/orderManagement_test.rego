package entitlements_test

import data.entitlements.orderManagement
import data.users["001"].product as dataProduct

test_orderManagement_false {
	not orderManagement with dataProduct as {}
}

test_orderManagement_enabled_in_both_platforms {
	orderManagement with dataProduct as {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}
		with input.userId as "001"
}

test_orderManagement_enabled_in_new_platform {
	orderManagement with dataProduct as {
		"version": "1",
		"sub_version": "3",
		"money_available": 100,
	}
		with input.userId as "001"
}
