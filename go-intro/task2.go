package main

import (
	"errors"
	"fmt"
	"log"
)

func task2() {
	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}

	min, err := minValue(x)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Min value in x: %d\n", min)
}

func minValue(arr []int) (int, error) {
	if len(arr) == 0 {
		return 0, errors.New("Empty array!")
	}
	var min int = arr[0]
	for _, value := range arr {
		if value < min {
			min = value
		}
	}
	return min, nil
}
