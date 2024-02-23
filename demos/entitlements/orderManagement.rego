package entitlements

default orderManagement = false

orderManagement {
	attributes = getUserProduct(input.userId)
	trace(attributes.version)
	attributes.version = "1"
	attributes.sub_version = ["2", "3"][_]
}
