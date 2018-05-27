package main

import (
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"time"
)

var isYoutube = regexp.MustCompile(`(www\.)youtube\.com|youtu\.be`)

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintf(os.Stderr, "Usage: %s [-no-retry] <url> [<url>]*", os.Args[0])
		os.Exit(1)
	}

	args := os.Args[1:]

	retry := true
	if os.Args[1] == "-no-retry" {
		args = os.Args[2:]
		retry = false
	}

	success := false
	var err error
	for {
		url := args[0]
		cmd := exec.Command("youtube-dl", "--no-mtime")
		cmd.Stdin = os.Stdin
		cmd.Stderr = os.Stderr
		cmd.Stdout = os.Stdout

		if isYoutube.MatchString(url) {
			// download youtube video in a lower resolution (saving bandwidth/space)
			cmd.Args = append(cmd.Args, "-f", "[height <=? 720]")
		}

		cmd.Args = append(cmd.Args, args...)
		printCommand(cmd)
		err = cmd.Run()
		if err != nil {
			fmt.Println("error...", err)
		}

		if !success && retry {
			time.Sleep(5 * time.Second)

			continue
		}

		break
	}

	if !success {
		os.Exit(1)
	}
}

func printCommand(cmd *exec.Cmd) {
	for _, arg := range cmd.Args {
		fmt.Printf("%s ", arg)
	}
	fmt.Println()
}
