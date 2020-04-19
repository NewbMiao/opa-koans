package main

import (
	"compress/gzip"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"

	"github.com/gorilla/mux"
)

// used for etag
var revisionMap = map[string]string{
	"rbac.tar.gz":      os.Getenv("REVISION_BUNDLE"),
	"discovery.tar.gz": os.Getenv("REVISION_DISCOVERY"),
}

func echo(w http.ResponseWriter, r *http.Request) {
	var reader io.ReadCloser
	var body = make([]byte, 10240)
	var err error
	switch r.Header.Get("Content-Encoding") {
	case "gzip":
		reader, _ = gzip.NewReader(r.Body)
		_, err = reader.Read(body)
		if err != io.EOF && err != nil {
			log.Println("Read gizp Error: ", err)
		}
		reader.Close()
	default:
		reader = r.Body
		body, err = ioutil.ReadAll(reader)
		if err != nil {
			log.Println("Read plain text Error: ", err)
		}
	}

	vars := mux.Vars(r)
	method := strings.Split(r.URL.Path, "/")[1]
	switch method {
	case "status":
		log.Printf("Recv request of status-%v, length: %v", vars["partition"], len(body))
	case "logs":
		log.Printf("Recv request of logs-%v, info: %v\n", vars["partition"], strings.Replace(string(body), "\n", "", -1))
	default:
		log.Printf("Recv request of %v-%v:\n%v\n", method, vars["partition"], string(body))

	}

	fmt.Fprint(w, "OK\n")
}

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/bundle/{file}", handleBundleFile)
	router.HandleFunc("/logs/{partition}", echo)
	router.HandleFunc("/status/{partition}", echo)
	router.HandleFunc("/auth", opaEval)
	srv := &http.Server{
		Handler: router,
		Addr:    "0.0.0.0:8888",
	}
	log.Fatal(srv.ListenAndServe())
}

func handleBundleFile(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	file := vars["file"]
	log.Println("Recv request of bundle:", r.RemoteAddr, file)

	if isFileStatusNotModify(w, r, file) {
		log.Println("file not changed, return 304")
		return
	}
	pwd, _ := os.Getwd()
	des := pwd + string(os.PathSeparator) + file
	desStat, err := os.Stat(des)
	if err != nil {
		log.Println("File Not Exit", des)
		http.NotFoundHandler().ServeHTTP(w, r)
	} else if desStat.IsDir() {
		log.Println("File Is Dir", des)
		http.NotFoundHandler().ServeHTTP(w, r)
	} else {
		fileData, err := ioutil.ReadFile(des)
		if err != nil {
			log.Println("Read File Err:", err.Error())
		} else {
			log.Println("Send File:", des)
			_, _ = w.Write(fileData)
		}
	}
}

func isFileStatusNotModify(w http.ResponseWriter, r *http.Request, file string) bool {
	etag := "default"
	if v, ok := revisionMap[file]; ok {
		etag = v
	}
	w.Header().Set("Etag", `"`+etag+`"`)
	w.Header().Set("Cache-Control", "max-age=7200") // 2h

	if match := r.Header.Get("If-None-Match"); match != "" {
		// unquote if needed
		m, _ := strconv.Unquote(match)
		if strings.EqualFold(m, etag) {
			w.WriteHeader(http.StatusNotModified)
			return true
		}
	}
	return false
}
