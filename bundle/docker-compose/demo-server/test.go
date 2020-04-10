package main

import (
	"compress/gzip"
	"io"
	"log"
	"os"
)

func main() {
	f, _ := os.Open("./rbac.tar.gz")
	defer f.Close()
	reader, err := gzip.NewReader(f)
	var body = make([]byte, 40890)
	n, err := reader.Read(body)
	if err != io.EOF && err != nil {
		log.Println("Read gizp Error: ", err)
	}
	log.Println(n, string(body))

}
