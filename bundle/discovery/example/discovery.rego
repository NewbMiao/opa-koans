package example

discovery = {
  "bundles": {
    "authz": {
      "service": "example_discovery",
      "resource": bundle_name
    }
  },
  "default_decision": "example_rbac/allow"
}

rt = opa.runtime()
region = rt.config.labels.region
bundle_name = region_bundle[region]

# region-bundle information
region_bundle = {
  "US": "bundle/rbac.tar.gz",
  "UK": "bundle/rbac.tar.gz"
}