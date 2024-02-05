package entitlements

default orderManagement = "false"

orderManagement = "true" {
	input.product.version == "1"
	input.product.sub_version = ["2", "3"][_]
}
