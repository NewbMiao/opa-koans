package entitlements_test

import data.entitlements.purchaseManagement
import input.product as dataProduct
import rego.v1

test_purchaseManagement_false if {
	not purchaseManagement with dataProduct as {}
}

test_purchaseManagement_enabled if {
	purchaseManagement with dataProduct as {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}
}

test_purchaseManagement_disabled if {
	not purchaseManagement with dataProduct as {
		"version": "1",
		"sub_version": "2",
		"money_available": 0,
	}
}
