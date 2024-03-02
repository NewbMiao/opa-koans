package entitlements

# import rego.v1

default orderManagement = false

orderManagement {
	attributes = input.product

	# trace(attributes.version)
	attributes.version = "1"
	attributes.sub_version = ["2", "3"][_]
}
