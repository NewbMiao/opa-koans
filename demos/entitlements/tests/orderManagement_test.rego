package entitlements_test

import rego.v1

import data.entitlements.orderManagement
import input.product as dataProduct

test_orderManagement_false if {
	not orderManagement with dataProduct as {}
}

test_orderManagement_enabled_in_both_platforms if {
	orderManagement with dataProduct as {
		"version": "1",
		"sub_version": "2",
		"money_available": 100,
	}
}

test_orderManagement_enabled_in_new_platform if {
	orderManagement with dataProduct as {
		"version": "1",
		"sub_version": "3",
		"money_available": 100,
	}
}
