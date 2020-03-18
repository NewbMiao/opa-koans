package example_virtual_doc

import data.example_func.is_config_file
import input.files

is_config {
	files := getFileNames
	is_config_file(files[_])
}

# eval_conflict_error: functions must not produce multiple outputs for same inputs
getFileNames[x] {
	file := files[_]
	file.type = "posix" # this is needed, without will report error
	file.path = trim(file.path)
	tmp := split(file.path, "/")
	x := tmp[minus(count(tmp), 1)]
}

getFileNames[x] {
	file := files[_]
	file.type = "traditional-mac" # this is needed, without will report error
	file.path = trim(file.path)
	tmp := split(file.path, ":")
	x := tmp[minus(count(tmp), 1)]
}
