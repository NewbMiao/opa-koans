package entitlements

import rego.v1

main := {
	"platforms": {"platforms": platforms},
	"orderManagement": {"enabled": orderManagement},
	"purchaseManagement": {"enabled": purchaseManagement},
}

# run
# opa eval -f values -d . -i input.json "data.entitlements.main"
# profile
# opa eval --profile -f pretty -d . -i input.json "data.entitlements.main"
# main = x if true
