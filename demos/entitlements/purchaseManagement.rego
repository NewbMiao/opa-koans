package entitlements

default purchaseManagement = "false"

purchaseManagement = "true" {
	input.product.money_available > 0
}
