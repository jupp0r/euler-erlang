package problem81to83

func Dijkstra(start *Node) (map[*Node]float64, map[*Node]*Node) {
	all := reachableNodes(start)
	q := NewPQ()
	distance := make(map[*Node]float64)
	prev := make(map[*Node]*Node)

	for n, _ := range all {
		if n == start {
			distance[n] = n.Weight
		} else {
			distance[n] = 999999999
		}
		prev[n] = nil
		q.Insert(n, distance[n])
	}

	for q.Len() > 0 {
		uc, _ := q.Pop()
		u := uc.(*Node)
		for _, neighbor := range u.Neighbors {
			alt := distance[u] + neighbor.Weight
			if alt < distance[neighbor] {
				distance[neighbor] = alt
				prev[neighbor] = u
				q.UpdatePriority(neighbor, alt)
			}
		}
	}

	return distance, prev
}

func reachableNodes(start *Node) map[*Node]struct{} {
	nodes := make(map[*Node]struct{})
	todo := map[*Node]struct{}{
		start: struct{}{},
	}

	for len(todo) != 0 {
		for visitedNode, _ := range todo {
			nodes[visitedNode] = struct{}{}
			for _, n := range visitedNode.Neighbors {
				_, ok := nodes[n]
				if !ok {
					todo[n] = struct{}{}
				}
			}
			delete(todo, visitedNode)
		}
	}
	return nodes
}
