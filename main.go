package main

import (
	"fmt"
	"net/http"

	"github.com/sirupsen/logrus"

	"rsc.io/quote"
)

var log = logrus.New()

func handler(w http.ResponseWriter, r *http.Request) {
	log.Debug("hellow world!")
	fmt.Fprintf(w, "Hello, World")
	fmt.Println(quote.Opt())
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}

func init() {
	log.Level = logrus.DebugLevel
}
