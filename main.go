package main

import (
	"fmt"
	"net/http"
    "rsc.io/quote"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World")
	fmt.Println(quote.Opt())
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
