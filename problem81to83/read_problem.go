package problem81to83

import (
	"bufio"
	"log"
	"os"
	"strconv"
	"strings"
)

func ReadProblem(fileName string) [][]Node {
	file, err := os.Open(fileName)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	result := make([][]Node, 0, 80)
	for scanner.Scan() {
		row := make([]Node, 0, 80)

		for _, num := range strings.Split(scanner.Text(), ",") {
			val, err := strconv.ParseFloat(num, 64)
			if err != nil {
				log.Fatal(err)
			}
			row = append(row, Node{
				Weight:    val,
				Neighbors: make([]*Node, 0),
			})
		}

		result = append(result, row)
	}
	return result
}
