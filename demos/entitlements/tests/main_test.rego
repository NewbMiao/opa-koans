package entitlements_test

import rego.v1

import data.entitlements.main

test_main_keys if {
	main.platforms
	main.orderManagement
	main.purchaseManagement
}
