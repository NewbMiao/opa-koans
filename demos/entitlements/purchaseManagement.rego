package entitlements

# import rego.v1

default purchaseManagement := false

purchaseManagement {
	attributes = input.product
	attributes.money_available > 0
}
