package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/open-policy-agent/opa/rego"
)

var query rego.PreparedEvalQuery

func init() {
	var err error
	query, err = rego.New(
		rego.LoadBundle("./bundle.tar.gz"),
		rego.Query("data.entitlements.main"),
	).PrepareForEval(context.Background())

	if err != nil {
		log.Fatalln("Opa init error:", err)
	}
}

func opaEval(w http.ResponseWriter, r *http.Request) {
	var input map[string]map[string]interface{}
	err := json.NewDecoder(r.Body).Decode(&input)

	log.Println("Recv request of opa eval:", input, len(input))
	if err != nil {
		if len(input) != 0 {
			fmt.Fprint(w, "Parse Input error:", err)
			return
		} 
		input = map[string]map[string]interface{}{
			"product": {
				"version":         "1",
				"sub_version":     "3",
				"money_available": 100,
			},
		}
		log.Println("fallback to default input:", input)
		
	}
	
	results, err := query.Eval(context.Background(), rego.EvalInput(input))
	if err != nil {
		fmt.Fprint(w, "Opa eval error:", err)
		return
	} else if len(results) == 0 {
		fmt.Fprint(w, "Opa eval error: no result")
		return
	}

	res, _ := json.Marshal(results[0].Expressions[0].Value)

	fmt.Fprint(w, (string)(res))
}
