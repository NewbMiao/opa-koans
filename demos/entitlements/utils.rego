package entitlements

fullVersion(product) = concat(".", [product.version, product.sub_version])

# get the user's product as a utility function
getUserProduct(userId) = data.users[userId].product
