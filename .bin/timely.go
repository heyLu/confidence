package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

func main() {
	cmd := exec.Command(os.Args[1], os.Args[2:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	start := time.Now()
	err := cmd.Run()
	duration := time.Since(start)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Running %s: %s\n", os.Args[0], err)
		os.Exit(1)
	}
	fmt.Fprintf(os.Stderr, "timely: %s\n", duration)
}
