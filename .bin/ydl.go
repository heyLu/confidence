package main

import (
	"fmt"
	"os"
	"os/exec"
	"regexp"
)

var isYoutube = regexp.MustCompile(`(www\.)youtube\.com|youtu\.be`)

func main() {
	url := os.Args[1]
	cmd := exec.Command("youtube-dl", "--no-mtime")
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
	cmd.Stdout = os.Stdout

	if isYoutube.MatchString(url) {
		// download youtube video in a lower resolution (saving bandwidth/space)
		cmd.Args = append(cmd.Args, "-f", "[height <=? 720]")
	}

	cmd.Args = append(cmd.Args, os.Args[1:]...)
	printCommand(cmd)
	err := cmd.Run()
	if err != nil {
		fmt.Println("error...", err)
		os.Exit(1)
	}
}

func printCommand(cmd *exec.Cmd) {
	for _, arg := range cmd.Args {
		fmt.Printf("%s ", arg)
	}
	fmt.Println()
}
