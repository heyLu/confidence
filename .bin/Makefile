all: rn since timely tmpview up working-time ydl

rn: rn.go
	go build $<

since: since.go
	go build $<

timely: timely.go
	go build timely.go

up: up.c
	clang -Wall -o up up.c

working-time: working-time.go
	go build working-time.go

ydl: ydl.go
	go build ydl.go

PREFIX = $(HOME)/.local

LP_REPO = $(HOME)/k/lp

tmpview: $(LP_REPO)/go/tmpview/*.go
	make -C $(LP_REPO)/go/tmpview PREFIX=$(PREFIX) install
