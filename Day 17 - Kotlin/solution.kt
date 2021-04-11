// Run via kotlinc solution.kt -include-runtime -d solution.jar && java -jar solution.jar

val steps = 394

fun part1(): Int {
    var current = 0
    val buffer = mutableListOf(0)
    (1..2017).forEach {
        current = ((current + steps) % it) + 1
        buffer.add(current, it)
    }
    return buffer[current.inc() % buffer.size]
}

fun part2(): Int {
        var current = 0
        var tracked = 0
        (1..50_000_000).forEach {
            current = ((current + steps) % it) + 1
            if (current == 1) tracked = it
        }
        return tracked
}

fun main() {
    println("Part 1: %s".format(part1()))
    println("Part 2: %s".format(part2()))
}
