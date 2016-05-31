package problem81to83

import (
	"reflect"
	"testing"
)

func TestReachableNodes(t *testing.T) {
	var a, b, c, d, e Node
	a = Node{
		Neighbors: []*Node{&b, &c},
	}
	b = Node{
		Neighbors: []*Node{&d},
	}
	d = Node{
		Neighbors: []*Node{&e},
	}

	expectedNodes := map[*Node]struct{}{
		&a: struct{}{},
		&b: struct{}{},
		&c: struct{}{},
		&d: struct{}{},
		&e: struct{}{},
	}

	reachable := reachableNodes(&a)
	if !reflect.DeepEqual(reachable, expectedNodes) {
		t.Fatalf("expected %v, got %v", expectedNodes, reachable)
	}
}

func TestDijkstraWithSameWeight(t *testing.T) {
	var a, b, c, d, e Node
	a = Node{
		Neighbors: []*Node{&b, &c},
		Weight:    1,
	}
	b = Node{
		Neighbors: []*Node{&d},
		Weight:    1,
	}
	c = Node{
		Neighbors: []*Node{},
		Weight:    1,
	}
	d = Node{
		Neighbors: []*Node{&e},
		Weight:    1,
	}
	e = Node{
		Neighbors: []*Node{},
		Weight:    1,
	}

	distances, paths := Dijkstra(&a)

	expectedDistances := map[*Node]float64{
		&a: 1,
		&b: 2,
		&c: 2,
		&d: 3,
		&e: 4,
	}

	expectedPaths := map[*Node]*Node{
		&a: nil,
		&b: &a,
		&c: &a,
		&d: &b,
		&e: &d,
	}

	if !reflect.DeepEqual(expectedDistances, distances) {
		t.Fatalf("expected %v, got %v", expectedDistances, distances)
	}

	if !reflect.DeepEqual(expectedPaths, paths) {
		t.Fatalf("expected %v, got %v", expectedPaths, paths)
	}
}
