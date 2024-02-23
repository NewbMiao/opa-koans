package entitlements

# run
# opa eval -f values -d . -i input.json "data.entitlements.main"
# profile
# opa eval --profile -f pretty -d . -i input.json "data.entitlements.main"
main := x {
	x = {
		"platforms": {"platforms": platforms},
		"orderManagement": {"enabled": orderManagement},
		"purchaseManagement": {"enabled": purchaseManagement},
	}
}
