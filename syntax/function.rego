package example_func

import input.files

is_config {
	file := files[_]
	x := getFileName(file.type, file.path)
	is_config_file(x)
}

# eval_conflict_error: functions must not produce multiple outputs for same inputs
getFileName(type, str) = x {
	type = "posix" # this is needed, without will report error
	str = trim(str)
	tmp := split(str, "/")
	x := tmp[minus(count(tmp), 1)]
}

getFileName(type, str) = x {
	type = "traditional-mac" # this is needed, without will report error
	str = trim(str)
	tmp := split(str, ":")
	x := tmp[minus(count(tmp), 1)]
}

# Or
# getFileName("posix", str) = x {
# 	str = trim(str)
# 	tmp := split(str, "/")
# 	x := tmp[minus(count(tmp), 1)]
# }

# getFileName("traditional-mac", str) = x {
# 	str = trim(str)
# 	tmp := split(str, ":")
# 	x := tmp[minus(count(tmp), 1)]
# }

is_config_file(str) {
	contains(str, ".yaml")
}

is_config_file(str) {
	contains(str, ".yml")
}

is_config_file(str) {
	contains(str, ".json")
}
