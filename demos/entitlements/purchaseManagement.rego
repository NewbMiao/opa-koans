package entitlements

default purchaseManagement = false

purchaseManagement {
	attributes = getUserProduct(input.userId)
	attributes.money_available > 0
}
