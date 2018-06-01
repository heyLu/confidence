all: rn since timely up ydl

rn: rn.go
	go build $<

since: since.go
	go build $<

timely: timely.go
	go build timely.go

up: up.c
	clang -o up up.c

ydl: ydl.go
	go build ydl.go
