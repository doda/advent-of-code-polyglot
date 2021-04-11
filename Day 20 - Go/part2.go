package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

type P struct {
	n  int
	px int
	py int
	pz int
	vx int
	vy int
	vz int
	ax int
	ay int
	az int
}

type Coord struct {
	x int
	y int
	z int
}

type Map map[Coord]P

func processLines() []P {
	scanner := bufio.NewScanner(os.Stdin)
	result := []P{}
	i := 0
	for scanner.Scan() {
		line := scanner.Text()
		r := regexp.MustCompile(`p=<([\d-]*),([\d-]*),([\d-]*)>, v=<([\d-]*),([\d-]*),([\d-]*)>, a=<([\d-]*),([\d-]*),([\d-]*)>`)
		gg := r.FindStringSubmatch(line)
		px, _ := strconv.Atoi(gg[1])
		py, _ := strconv.Atoi(gg[2])
		pz, _ := strconv.Atoi(gg[3])
		vx, _ := strconv.Atoi(gg[4])
		vy, _ := strconv.Atoi(gg[5])
		vz, _ := strconv.Atoi(gg[6])
		ax, _ := strconv.Atoi(gg[7])
		ay, _ := strconv.Atoi(gg[8])
		az, _ := strconv.Atoi(gg[9])

		result = append(result, P{i, px, py, pz, vx, vy, vz, ax, ay, az})
		i += 1
	}
	return result
}

func simulate(particles []P) {
	universe := Map{}
	numParticles := 0
	for _, p := range particles {
		universe[Coord{p.px, p.py, p.pz}] = p
	}

	for i := 0; i < 1000; i++ {
		collisions := []Coord{}
		nextUniverse := Map{}
		for particleCoord, particle := range universe {
			particle.vx += particle.ax
			particle.vy += particle.ay
			particle.vz += particle.az
			nextCoord := Coord{
				particleCoord.x + particle.vx,
				particleCoord.y + particle.vy,
				particleCoord.z + particle.vz,
			}

			_, alreadyFull := nextUniverse[nextCoord]
			if alreadyFull {
				collisions = append(collisions, nextCoord)
			} else {
				nextUniverse[nextCoord] = particle
			}

		}

		for _, collisionCoord := range collisions {
			delete(nextUniverse, collisionCoord)
		}
		numParticles = 0
		for range nextUniverse {
			numParticles += 1
		}
		universe = nextUniverse
	}
	fmt.Println("Part 2: ", numParticles)
}

func main() {
	Ps := processLines()
	simulate(Ps)
}
