package example_comprehensions

import input.files

# object comprehensions
group_files_by_type := {type: paths |
	file := files[_]
	type := file.type
	paths := [path |
		tmp := files[_]
		tmp.type == type
		path := tmp.path
	]
}

# object comprehensions
group_files_by_file_extension := {ext: paths |
	# set: ["yaml", "yml", "json"]
	extSets := {e | e = regex.find_all_string_submatch_n(".*\\.(.*)$", files[_].path, -1)[0][1]}

	ext := extSets[_]
	paths := [path |
		tmp := files[_]
		endswith(tmp.path, ext)
		path := tmp.path
	]
}

# set comprehensions
convert_all_to_posix_path_sets := {path |
	path1 := {p |
		file := files[_]
		file.type == "posix"
		p := file.path
	}

	path2 := {p |
		file := files[_]
		file.type == "traditional-mac"
		p := replace(replace(file.path, "Macintosh HD", ""), ":", "/")
	}

	path := path1 | path2
}

# array comprehensions
convert_all_to_posix_path_array := [path |
	path1 := [p |
		file := files[_]
		file.type == "posix"
		p := file.path
	]

	path2 := [p |
		file := files[_]
		file.type == "traditional-mac"
		p := replace(replace(file.path, "Macintosh HD", ""), ":", "/")
	]

	path := array.concat(path1, path2)
]
