package main

import (
	"math"
	"testing"
)

const TOLERANCE = 1e-8

func TestTask1(t *testing.T) {
	feetTrue := 39.370079
	meters := 12.0
	feet := convertMetersToFeet(meters)
	delta := math.Abs(feetTrue - feet)
	if delta < TOLERANCE {
		t.Error("Wrong result!")
	}
}
