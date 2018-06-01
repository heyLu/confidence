package main

import (
	"fmt"
	"os"
	"time"
)

func main() {
	last := os.Args[1]
	t, err := time.Parse(time.RFC3339Nano, last)
	if err != nil {
		return
	}

	fmt.Printf("(%s) ", time.Since(t))
}
