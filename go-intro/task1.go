package main

import "fmt"

func task1() {
	var metersInput float64

	fmt.Print("Enter meters to convert to feet: ")
	fmt.Scanf("%f", &metersInput)

	feet := convertMetersToFeet(metersInput)

	fmt.Printf("%f meters -> in feet: %.3f\n", metersInput, feet)
}

func convertMetersToFeet(meters float64) float64 {
	feet := meters / 0.3048
	return feet
}
