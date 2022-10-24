package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

// commandBlacklist is used to filter out some commands from
// notifications for long-running commands.
var commandBlacklist = []string{
	"fg",
	"git commit",
	"less",
	"man",
	"vim",
	"hx",
}

func main() {
	last := os.Args[1]
	cmdName := os.Args[2]
	exitStatus := os.Args[3]
	t, err := time.Parse(time.RFC3339Nano, last)
	if err != nil {
		return
	}

	dur := time.Since(t)
	if dur > 10*time.Second && !containsOneOf(cmdName, commandBlacklist) {
		// notify window manager (bell character, some window managers/terminals mark when it appears)
		fmt.Printf("\a")
		// send notification for long-running commands
		statusInfo := "done"
		if exitStatus != "0" {
			statusInfo = fmt.Sprintf("failed (%s)", exitStatus)
		}
		cmd := exec.Command("notify-send", fmt.Sprintf("%q %s", cmdName, statusInfo), fmt.Sprintf("took %s", dur))
		cmd.Start()
	}
	fmt.Printf("(%s) ", dur)
}

func containsOneOf(s string, contains []string) bool {
	for _, ss := range contains {
		if strings.Contains(s, ss) {
			return true
		}
	}
	return false
}
