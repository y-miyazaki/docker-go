package main

import (
	"errors"
	"fmt"
	"net/http"

	"github.com/sirupsen/logrus"
	"rsc.io/quote"
)

var log = logrus.New()

func handler(w http.ResponseWriter, r *http.Request) {
	log.Level = logrus.DebugLevel

	log.Debug("hellow world!")
	n, i := fmt.Fprintf(w, "Hello, World")
	fmt.Println(n)
	fmt.Println(i)

	fmt.Println(quote.Opt())
	_ = testA()
}
func testA() error {
	return errors.New("test")
}

func main() {
	http.HandleFunc("/", handler)
	_ = http.ListenAndServe(":8080", nil)
}
