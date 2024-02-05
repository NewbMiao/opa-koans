package entitlements_test

import data.entitlements.purchaseManagement

test_purchaseManagement_false {
	"false" = purchaseManagement with input as {}
}

test_purchaseManagement_both {
	"true" = purchaseManagement with input as {"product": {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}}
}

test_purchaseManagement_both {
	"false" = purchaseManagement with input as {"product": {
		"version": "1",
		"sub_version": "2",
		"money_available": 0,
	}}
}

test_purchaseManagement_tradiecore {
	"true" = purchaseManagement with input as {"product": {
		"version": "1",
		"sub_version": "3",
		"money_available": 100,
	}}
}
