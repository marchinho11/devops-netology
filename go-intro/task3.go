package main

import (
	"fmt"
)

func task3() {
	numbers := generateNumbers()
	fmt.Println(numbers)
}

func generateNumbers() []int {
	arr := []int{}
	for i := 1; i <= 100; i++ {
		if i%3 == 0 {
			arr = append(arr, i)
		}
	}
	return arr
}
