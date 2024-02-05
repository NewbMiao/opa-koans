package entitlements_test

import data.entitlements.orderManagement

test_orderManagement_false {
	"false" = orderManagement with input as {}
}

test_orderManagement_true {
	"true" = orderManagement with input as {"product": {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}}
}

test_orderManagement_true_2 {
	"true" = orderManagement with input as {"product": {
		"version": "1",
		"sub_version": "3",
		"money_available": 100,
	}}
}
