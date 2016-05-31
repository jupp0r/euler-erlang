package main

import (
	"problem81to83"

	"github.com/prometheus/common/log"
)

func main() {
	matrix := problem81to83.ReadProblem("problem81.txt")
	rows := len(matrix) - 1
	columns := len(matrix[0]) - 1
	for i, _ := range matrix {
		for j, _ := range matrix[i] {
			if i < rows {
				matrix[i][j].Neighbors = append(matrix[i][j].Neighbors, &matrix[i+1][j])
			}
			if j < columns {
				matrix[i][j].Neighbors = append(matrix[i][j].Neighbors, &matrix[i][j+1])
			}
		}
	}

	start := &matrix[0][0]
	_, prev := problem81to83.Dijkstra(start)

	pointer := &matrix[rows][columns]
	sum := float64(0)
	for pointer != start {
		sum = sum + pointer.Weight
		pointer = prev[pointer]
	}

	log.Info(sum + (*start).Weight)
}
