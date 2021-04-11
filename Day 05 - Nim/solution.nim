import strutils,sequtils

proc solve( instr_copy: seq[int], part2 = false): int =
  var instructions = instr_copy
  var ic = 0
  var count = 0
  while ic >= 0 and ic < instructions.len:
    let icnext = ic + instructions[ic]
    if part2 and instructions[ic] >= 3:
        instructions[ic] -= 1
    else:
        instructions[ic] += 1
    ic = icnext
    count += 1
  return count

let instructions = "input.txt".readFile.strip.splitLines.map parseInt
echo solve(instructions)
echo solve(instructions,true)
