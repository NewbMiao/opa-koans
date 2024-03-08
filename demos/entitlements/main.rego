package entitlements

import rego.v1

main := {
	"platforms": {"platforms": platforms},
	"orderManagement": {"enabled": orderManagement},
	"purchaseManagement": {"enabled": purchaseManagement},
}

# run as bundle
# opa eval -f values -b .  -i input.json "data.entitlements.main"
# or run it directly, but need to ignore bundle.tar.gz to avoid double merge data.jso
# opa eval -f values -d . --ignore bundle.tar.gz  -i input.json "data.entitlements.main"
# profile
# opa eval --profile -f pretty -d . --ignore bundle.tar.gz  -i input.json "data.entitlements.main"
