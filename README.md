![](/images/logo.jpg)

Inspired by others who had done this (and initially thinking it’d be close to impossible) I recently completed the [Advent of Code](https://adventofcode.com/2017) series of programming challenges for the year 2017 using 25 different languages.

I had done [2018](https://adventofcode.com/2018) in Rust and [2020](https://adventofcode.com/2020) in Go, each to better learn the individual languages, but this time around set myself the artificial restriction that I’d have to use a different programming language or tool for every day of the challenge.

You can find problem descriptions for all days here: https://adventofcode.com/2017/

A few notes on Days that stood out:

[Day 01 - Excel](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2001%20-%20Excel "Day 01 - Excel"):

I got the idea for using Excel from Reddit (like I did with a few of the language choices):

![Selection_231.png](/images/Selection_231.png)


[Day 03 - Google Chrome](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2003%20-%20Google%20Chrome "Day 03 - Google Chrome")

The interesting thing about this challenge was that I was solve it entirely without writing code:

```
For part 1:

17  16  15  14  13
18   5   4   3  12
19   6   1   2  11
20   7   8   9  10
21  22  23---> ...

We can figure out which grid-width for the smallest square containing the integer we're looking for is via
sqrt(289326) = 537.89 which means the width of the square we're working with is 539 (it has to be odd-numbered)

We can then figure out where we are on the square's sides and how far we have to walk to the lower-right square
(equidistant to the manhattan distance to the center for our input)
via
(289326-(537^2)+1%539) = 419
i.e. subtract the next smaller square, add 1 to take care of the offset (notice how the first number, 10, is up 1 from the bottom-right corner),
and modulo by the bigger square size to take off the "full rows" that we're having to traverse
Or via Google Chrome :)
https://www.google.com/search?q=%28%28289326-%28537%5E2%29%2B1%29%25539%29

For part 2:

I simply googled the input sequence "1, 1, 2, 4, 5, 10, 11, 23, 25, 26"
https://www.google.com/search?q=%221%2C+1%2C+2%2C+4%2C+5%2C+10%2C+11%2C+23%2C+25%2C+26%22
since I had a feeling that this integer sequence would have to be online somewhere :)
```
[Day 04 - VisualBasic .NET](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2004%20-%20VisualBasic%20.NET "Day 04 - VisualBasic .NET")

Learning VisualBasic in the year 2021 is a privilege :D

The language actually seemed reasonable compared to some of the other ones I used.

[Day 11 - Bash](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2011%20-%20Bash "Day 11 - Bash")

![Selection_230.png](/images/Selection_230.png)

This is probably the one I’m most proud of: It shows how an at first seemingly difficult problem melts away when you’re working with the right abstraction, in this case a [Cube Coordinate system](https://www.redblobgames.com/grids/hexagons/#coordinates-cube). I was worried about using Bash but I actually managed to golf a neat little solution that’s small enough to include here

```
#!/bin/bash

IFS=',' read -ra steps

for dir in "$"; do
    case $dir in
        n) ((y++)); ((z--)) ;;
        s) ((y--)); ((z++)) ;;
        ne) ((x++)); ((z--)) ;;
        nw) ((x--)); ((y++)) ;;
        se) ((x++)); ((y--)) ;;
        sw) ((x--)); ((z++)) ;;
    esac
    let distance="((x<0?-x:x)+(y<0?-y:y)+(z<0?-z:z))/2"
    let highest="highest<distance?distance:highest"
done

echo Part 1: $distance
echo Part 2: $highest
```
This program walks through a series of instructions on a hexagonal grid (north, east, south-east etc.) and keeps track of how far away from it’s origin point it is maximally during its trip and how far away it winds up. Praise be that in Bash you’re allowed to increment uninitialized values.

[Day 13 - SQL](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2013%20-%20SQL "Day 13 - SQL")

Another very fun day as I was able to solve purely with PostgreSQL by inserting the input data into a table and then running 2 very short queries on it:

```
CREATE TABLE layers (
    depth integer,
    range integer
);

COPY layers FROM '$(pwd)/input.txt' DELIMITER ':' CSV;

-- Part 1:
SELECT SUM((depth % (range \* 2 - 2)  = 0)::int \* depth \* range) FROM layers;

-- Part 2:
SELECT i from (
    SELECT i, (
        SELECT SUM(depth \* range) severity from layers WHERE (depth + i ) % (range \* 2 - 2) = 0
    )
    FROM generate\_series(1, 1000000) i
) x WHERE severity IS NULL LIMIT 1;
```

I spent quite a bit of time stuck on that second part with a bug thanks to Postgres’ special NULL handling. -\_-

[Day 14 - Perl](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2014%20-%20Perl "Day 14 - Perl")

I can understand my brother’s distaste for Perl a lot better after solving Day 14:

*   StackOverflow suggests in order to get “print” to print newlines: just execute with perl -l
    
*   Seeing a typoed/uninitialized variable is fine for Perl with default settings: just pretend its null (I thought this was a fun trick in Bash…. but in Perl it caught me quite badly)
    
*   Functions dont define function signatures
    

Though I was fine after I got around these. I can see why people would like the ability to be extremely terse in Perl though (Eric Wastl, the creator of AoC apparently writes most of his code in Perl)

[Day 18 - Rust](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2018%20-%20Rust "Day 18 - Rust")

It was fun to get to re-use Rust here after I spent some time learning it in 2020. I’m still an abject beginner in in Rust but the Part 2 reveal of this problem was very cool: Run the part 1 solution in parallel until you reach a deadlock. This was very easy to accomplish with Rust’s concurrency primitives :)

[Day 23 - PHP](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2023%20-%20PHP "Day 23 - PHP")  
For as much as people decry PHP I actually found it to be OK for Day 23, however most of the challenge in that day was reverse engineering some assembly — not much functionality was needed from the language bar a hash map, a while, and some if statements…

[Day 24 - Python](https://github.com/doda/advent-of-code-polyglot/tree/master/Day%2024%20-%20Python "Day 24 - Python")

I saved my best language for last only to find that the last problem was a very simple DFS with backtracking… I enjoyed my hack for part 2 (by adding 1000000 on every step to push the longest solution to the top while still being able to modulo out the strength of it).

The more I do coding challenges like this the more I catch myself writing slightly lazy / copy paste code if it allows me to get on with my life rather than finding the most elegant abstraction / terse code.

Closing thoughts:
-----------------

All in all a very fun challenge. At times it got frustrating (having to google how to parse strings in the umpteenth language), and a few times I had to back out of trying to use a language (such as FORTRAN or k3, that were just too cumbersome to use). 

Despite the problems being harder later into the challenge (I would say the first 10 Days are generally trivial problems) I found them easier to complete as I tried to use obscure languages first, and languages that I’m more familiar with later. Give a man a list of strings, a number parser and a hash table and life becomes much easier :)