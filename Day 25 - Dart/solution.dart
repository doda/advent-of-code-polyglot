import 'dart:io';

main() {
  var line;
  var buf = "";
  // This is kinda janky -- oh well
  while (true) {
    line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    buf += line + "\n";
  }
  var parts = buf.split("\n\n");

  var wordPattern = RegExp(r"\b([A-Z0-9]+|right|left)\b");
  var programList = parts
      .map((part) => wordPattern.allMatches(part).map((m) => m[0]).toList())
      .toList();
  var starterValues = programList.removeAt(0);

  var state = starterValues[0];
  var iterations = int.parse(starterValues[1] ?? "0");

  var tape = new Map();
  var programs = new Map();

  for (var i = 0; i < programList.length; i++) {
    var program = programList[i];
    programs[program[0]] = program;
  }

  var curPos = 0;
  var curProgram;

  for (var i = 0; i < iterations; i++) {
    curProgram = programs[state];
    var zeroWriteVal = curProgram[2] == "1" ? 1 : 0;
    var zeroNextMove = curProgram[3] == "left" ? -1 : 1;
    var zeroNextState = curProgram[4];
    var oneWriteVal = curProgram[6] == "1" ? 1 : 0;
    var oneNextMove = curProgram[7] == "left" ? -1 : 1;
    var oneNextState = curProgram[8];

    var curValue = tape[curPos] ?? 0;
    if (curValue == 0) {
      tape[curPos] = zeroWriteVal;
      curPos += zeroNextMove;
      state = zeroNextState;
    } else {
      tape[curPos] = oneWriteVal;
      curPos += oneNextMove;
      state = oneNextState;
    }
  }

  var sum = tape.values.reduce((a, b) => a + b);
  print("Part 1: $sum");
}
