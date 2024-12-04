package main

import (
	"fmt"
	"time"
)

func main() {
	for {
		fmt.Println("Hello World")
		time.Sleep(300 * time.Second)
	}
}
