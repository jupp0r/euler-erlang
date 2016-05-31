package problem81to83

import "testing"

func TestNodeEqualityForEmptyNodes(t *testing.T) {
	var a, b Node

	if !a.Equals(&b) || !b.Equals(&a) {
		t.Fatalf("empty nodes should be equalA")
	}
}

func TestNodeEqualityForDifferentNodes(t *testing.T) {
	a := Node{
		Weight: float64(10),
	}

	b := Node{
		Weight:    float64(12),
		Neighbors: []*Node{&a},
	}

	if a.Equals(&b) {
		t.Fatalf("nodes shouldn't be equal but they are")
	}
}

func TestNodeEqualityForEqualNodes(t *testing.T) {
	var a Node
	b := Node{
		Weight:    float64(12),
		Neighbors: []*Node{&a},
	}

	a = b

	if !a.Equals(&b) {
		t.Fatalf("nodes should be equal but they aren't")
	}
}
