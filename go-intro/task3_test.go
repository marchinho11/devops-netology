package main

import (
	"testing"
)

func TestTask3(t *testing.T) {
	numbersTrue := []int{3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99}
	numbers := generateNumbers()

	if len(numbersTrue) != len(numbers) {
		t.Error("Wrong result!")
	}

	for i, v := range numbersTrue {
		if v != numbers[i] {
			t.Error("Wrong result!")
		}
	}
}
