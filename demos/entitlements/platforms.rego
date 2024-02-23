package entitlements

import data.rules.platforms as platforms_rules

hasNewPlatform = "newPlatform" {
	attributes = getUserProduct(input.userId)
	x := fullVersion(attributes)
	trace(x)
	x = platforms_rules.newPlatform.product.fullVersion[_]
}

hasOldPlatform = "oldPlatform" {
	attributes = getUserProduct(input.userId)
	x := fullVersion(attributes)
	x = platforms_rules.oldPlatform.product.fullVersion[_]
}

platforms = array.concat([x | x := hasOldPlatform; x], [x | x := hasNewPlatform; x])
