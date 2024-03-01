package main

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/entitlements", opaEval)
	srv := &http.Server{
		Handler: router,
		Addr:    "0.0.0.0:8888",
	}
	log.Println("Server starting at", srv.Addr)
	log.Fatal(srv.ListenAndServe())
}
