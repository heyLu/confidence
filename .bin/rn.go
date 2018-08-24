package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintf(os.Stderr, "Usage: %s <cmd> [<args>*]\n", os.Args[0])
		os.Exit(1)
	}

	win := xGetActiveWindow()

	cmd := exec.Command(os.Args[1], os.Args[2:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	start := time.Now()
	err := cmd.Run()
	duration := time.Since(start)

	winAfter := xGetActiveWindow()

	msg := fmt.Sprintf("Finished running %q in %s", cmdToString(cmd), duration)
	if duration > 1*time.Second && win != winAfter {
		notifyCompletion(msg)
	}
	fmt.Fprintln(os.Stderr, msg)

	success := true
	if err != nil {
		success = false
		fmt.Fprintf(os.Stderr, "Error: %s\n", err)
	}

	if !success {
		os.Exit(1)
	}
}

func notifyCompletion(msg string) {
	notifyCmd := exec.Command("notify-send", msg)
	notifyCmd.Run()
}

func xGetActiveWindow() string {
	cmd := exec.Command("xdotool", "getactivewindow")
	out, err := cmd.Output()
	if err != nil {
		return ""
	}
	return string(out)
}

func cmdToString(cmd *exec.Cmd) string {
	return strings.Join(cmd.Args, " ")
}
