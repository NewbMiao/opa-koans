package entitlements

import rego.v1

import data.rules.platforms as platforms_rules

hasNewPlatform = "newPlatform" if {
	attributes = input.product
	x := fullVersion(attributes)

	# trace(x)
	platforms_rules.newPlatform.product.fullVersion[_] = x
}

hasOldPlatform := "oldPlatform" if {
	attributes = input.product
	x := fullVersion(attributes)
	platforms_rules.oldPlatform.product.fullVersion[_] = x
}

platforms = array.concat([x | x := hasOldPlatform; x], [x | x := hasNewPlatform; x])
