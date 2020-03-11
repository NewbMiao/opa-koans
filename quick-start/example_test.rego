package example_rbac_test

import data.example_rbac

# tests to coverage 100%

test_not_allow {
	not example_rbac.allow with input as {}
}

test_allow {
	example_rbac.allow with input as {
		"action": {
			"operation": "read",
			"resource": "widgets",
		},
		"subject": {"user": "inspector-alice"},
	}
}
