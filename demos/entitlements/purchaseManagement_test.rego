package entitlements_test

import data.entitlements.purchaseManagement
import data.users["001"].product as dataProduct

test_purchaseManagement_false {
	not purchaseManagement with dataProduct as {}
}

test_purchaseManagement_enabled {
	purchaseManagement with dataProduct as {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}
		with input.userId as "001"
}

test_purchaseManagement_disabled {
	not purchaseManagement with dataProduct as {
		"version": "1",
		"sub_version": "2",
		"money_available": 0,
	}
		with input.userId as "001"
}
