package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/open-policy-agent/opa/metrics"
	"github.com/open-policy-agent/opa/rego"
)

var query rego.PreparedEvalQuery
var m = metrics.New()

func init() {
	var err error
	query, err = rego.New(
		rego.LoadBundle("./rbac.tar.gz"),
		rego.Query("x = data.rbac.allow"),
		rego.Metrics(m),
	).PrepareForEval(context.Background())

	if err != nil {
		log.Fatalln("Opa init error:", err)
	}
}

func opaEval(w http.ResponseWriter, r *http.Request) {
	var input map[string]map[string]string
	err := json.NewDecoder(r.Body).Decode(&input)

	log.Println("Recv request of opa eval:", input)
	if err != nil {
		fmt.Fprint(w, "Parse Input error:", err)
		return
	}
	results, err := query.Eval(context.Background(), rego.EvalInput(input))
	if err != nil {
		fmt.Fprint(w, "Opa eval error:", err)
		return
	} else if len(results) == 0 {
		fmt.Fprint(w, "Opa eval error: no result")
		return
	}

	res, _ := json.Marshal(results)
	log.Println("Opa result:", results[0].Expressions[0].Value)

	tmp, _ := m.MarshalJSON()
	log.Println("Opa metrics:", string(tmp))

	fmt.Fprint(w, string(res))
}
