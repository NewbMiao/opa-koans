package example_virtual_doc

import data.example_func.is_config_file
import input.files

is_config {
	is_config_file(getFileNames[_])
}

# virtual document's input/output is finite, and is generated document,  can be query, support iteration, will be output
getFileNames[x] {
	file := files[_]
	file.type = "posix"
	file.path = trim(file.path)
	tmp := split(file.path, "/")
	x := tmp[count(tmp) - 1]
}

getFileNames[x] {
	file := files[_]
	file.type = "traditional-mac"
	file.path = trim(file.path)
	tmp := split(file.path, ":")
	x := tmp[count(tmp) - 1]
}
