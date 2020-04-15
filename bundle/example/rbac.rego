package rbac

default allow = false

# allow will be true when user has role and role has permission
allow {
	some role_name
	user_has_role[role_name]
	role_has_permission[role_name]
}

# check user role binding exist
user_has_role[role_name] {
	role_binding = data.bindings[_]
	role_binding.role = role_name
	role_binding.user == input.subject.user
}

# check role permission exist
role_has_permission[role_name] {
	role = data.roles[_]
	role.name = role_name
	role.operation == input.action.operation
	role.resource == input.action.resource
}
