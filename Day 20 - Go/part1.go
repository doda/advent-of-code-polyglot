package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"sort"
	"strconv"
)

type P struct {
	n        int
	x        int
	y        int
	z        int
	mnhdistv int
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func processLines() []P {
	scanner := bufio.NewScanner(os.Stdin)
	result := []P{}
	i := 0
	for scanner.Scan() {
		line := scanner.Text()
		r := regexp.MustCompile(`a=<([\d-]*),([\d-]*),([\d-]*)>`)
		gg := r.FindStringSubmatch(line)
		x, _ := strconv.Atoi(gg[1])
		y, _ := strconv.Atoi(gg[2])
		z, _ := strconv.Atoi(gg[3])
		mnhdistv := abs(x) + abs(y) + abs(z)

		result = append(result, P{i, x, y, z, mnhdistv})
		i += 1
	}
	return result
}

func main() {
	Ps := processLines()
	sort.SliceStable(Ps, func(i, j int) bool {
		return Ps[i].mnhdistv < Ps[j].mnhdistv
	})
	fmt.Println("Part 1: ", Ps[0].n)
}
