package example_func

is_txt {
	x := getSuffix("posix", "/Users/newbmiao/Documents/a.txt")
	x == "a.txt"
}

is_txt {
	x := getSuffix("mac", "Macintosh HD:Users:newbmiao:Documents:a.txt")
	x == "a.txt"
}

getSuffix("posix", str) = x {
	str = trim(str)
	tmp := split(str, "/")
	x := tmp[minus(count(tmp), 1)]
}

getSuffix("mac", str) = x {
	str = trim(str)
	tmp := split(str, ":")
	x := tmp[minus(count(tmp), 1)]
}
