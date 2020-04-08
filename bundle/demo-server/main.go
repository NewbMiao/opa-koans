package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
)

func echo(w http.ResponseWriter, req *http.Request) {
	body, _ := ioutil.ReadAll(req.Body)
	log.Printf("Recv request of %v: %v\n", req.URL.Path[1:len(req.URL.Path)], string(body))

	fmt.Fprintf(w, "OK\n")
}

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/bundle/{file}", handleBundleFile)
	router.HandleFunc("/logs", echo)
	router.HandleFunc("/status", echo)
	srv := &http.Server{
		Handler: router,
		Addr:    "localhost:8888",
	}
	log.Fatal(srv.ListenAndServe())
}

func handleBundleFile(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	log.Println("Recv request of bundle:", r.RemoteAddr, vars["file"])
	pwd, _ := os.Getwd()
	des := pwd + string(os.PathSeparator) + vars["file"]
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
			w.Write(fileData)
		}
	}
}
