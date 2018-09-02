// Command working-time tracks how much time you've spent working today.
//
// It doesn't do anything fancy, it just notes when you've logged in today,
// and then tracks how much time has passed since then.
package main

import (
	"encoding/json"
	"fmt"
	"os"
	"path"
	"time"
)

// Day contains information about how long you've worked today.
type Day struct {
	Start time.Time     `json:"start"`
	Break time.Duration `json:"break,omitempty"`
}

// modes:
//  - no such file or directory => record start
//  - start is not today => record start
//
// after, log time since start

func main() {
	dayFile := path.Join(os.Getenv("HOME"), ".cache/working-day.json")
	now := time.Now()
	day := readDay(dayFile)

	if day.Start.Day() != now.Day() {
		day = Day{Start: now}
		writeDay(dayFile, day)
	}

	if len(os.Args) > 2 && os.Args[1] == "break" {
		dur, err := time.ParseDuration(os.Args[2])
		if err != nil {
			fmt.Fprintln(os.Stderr, err)
			os.Exit(1)
		}
		fmt.Fprintf(os.Stderr, "took a %s break\n", dur)
		day.Break += dur
		writeDay(dayFile, day)
	}

	dur := time.Since(day.Start) - day.Break
	hours := dur.Hours()
	minutes := dur.Minutes() - float64(int(hours)*60)
	fmt.Printf("%d:%02d\n", int(hours), int(minutes))
}

func readDay(path string) Day {
	f, err := os.Open(path)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		return Day{Start: time.Now()}
	}
	defer f.Close()

	var day Day
	dec := json.NewDecoder(f)
	err = dec.Decode(&day)
	if err != nil {
		fmt.Println("invalid json")
		os.Exit(1)
	}

	return day
}

func writeDay(path string, day Day) {
	f, err := os.OpenFile(path, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0640)
	if err != nil {
		fmt.Println("write error")
		os.Exit(1)
	}
	defer f.Close()

	enc := json.NewEncoder(f)
	err = enc.Encode(day)
	if err != nil {
		fmt.Println("write error")
		os.Exit(1)
	}
}
