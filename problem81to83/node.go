package problem81to83

type Node struct {
	Neighbors []*Node
	Weight    float64
}

func (n *Node) Equals(o *Node) bool {
	if n.Weight != o.Weight {
		return false
	}

	if len(n.Neighbors) != len(o.Neighbors) {
		return false
	}

	for i, _ := range n.Neighbors {
		if o.Neighbors[i] != n.Neighbors[i] {
			return false
		}
	}
	return true
}
