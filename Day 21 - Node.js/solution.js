_ = require("lodash");
readline = require("readline");

rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

String.prototype.replaceAt = function (index, replacement) {
  return (
    this.substr(0, index) +
    replacement +
    this.substr(index + replacement.length)
  );
};

rotate = (ruleInput) => {
  out = _.clone(ruleInput);
  n = ruleInput.length;
  for (row = 0; row < n; row++) {
    for (col = 0; col < n; col++) {
      out[row] = out[row].replaceAt(col, ruleInput[col][n - 1 - row]);
    }
  }
  return out;
};

flip = (ruleInput) =>
  _.map(ruleInput, (s) => _.join(_.reverse(_.split(s, "")), ""));

rules = [];
state = [".#.", "..#", "###"];
allRules = [];

getSubs = (state, size) => {
  out = [];
  n = state.length;
  for (row = 0; row < n; row++) {
    rowZero = row % size === 0;
    if (rowZero) {
      // new row
      out.push([]);
    }
    for (col = 0; col < n; col++) {
      colZero = col % size === 0;
      if (rowZero && colZero) {
        out[out.length - 1].push(
          _.map(_.slice(state, row, row + size), (row) => {
            return row.substr(col, size);
          })
        );
      }
    }
  }
  return out;
};

joinHori = (...args) => _.map(_.zip(...args), (x) => _.join(x, ""));

joinSubs = (state) => {
  return _.flatten(_.map(state, (subexp) => joinHori(...subexp)));
};

completeRules = {};
rl.on("line", (line) => {
  [input, output] = _.split(_.trim(line), " => ");
  rules.push({ input: _.split(input, "/"), output: _.split(output, "/") });
}).on("close", () => {
  // Build up rules by flipping and rotating
  _.map(rules, (rule) => {
    input = rule.input;
    output = rule.output;
    _.times(2, () => {
      _.times(4, () => {
        allRules.push({ input: _.join(input, ""), output: output });
        completeRules[input] = output;
        input = rotate(input);
      });
      input = flip(input);
    });
  });

  // Iterate by splitting, expanding and joining the state
  iterations = 18;
  _.times(iterations, (round) => {
    curSize = state[0].length;

    if (curSize % 2 === 0) {
      subGridMap = getSubs(state, 2);
    } else if (curSize % 3 === 0) {
      subGridMap = getSubs(state, 3);
    }

    expandedGrid = _.map(subGridMap, (subGridRow) => {
      return _.map(subGridRow, (subGrid) => {
        return completeRules[_.join(subGrid)];
      });
    });

    state = joinSubs(expandedGrid);
    pixelsOn = (_.join(state, "").match(/#/g) || []).length;
    if (round == 4) {
      console.log("Part 1:", pixelsOn);
    }
    if (round == 17) {
      console.log("Part 2:", pixelsOn);
    }
  });
});
