package entitlements

import data.rules.platforms as platforms_rules

hasNewPlatform = "newPlatform" {
	x := fullVersion(input.product)
	x = platforms_rules.newPlatform.product.fullVersion[_]
}

hasOldPlatform = "oldPlatform" {
	x := fullVersion(input.product)
	x = platforms_rules.oldPlatform.product.fullVersion[_]
}

platforms = array.concat([x | x := hasOldPlatform; x], [x | x := hasNewPlatform; x])
