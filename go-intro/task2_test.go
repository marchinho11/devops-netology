package main

import "testing"

func TestTask2Success(t *testing.T) {
	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	min, error := minValue(x)
	if error != nil {
		t.Error("Error is not expected!")
	}
	if min != 9 {
		t.Error("Wrong result!")
	}
}

func TestTask2Fail(t *testing.T) {
	x := []int{}
	_, error := minValue(x)
	if error == nil {
		t.Error("Error is expected! Array is empty")
	}
}
