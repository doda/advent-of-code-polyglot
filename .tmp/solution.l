%{
// Run via "flex solution.l && gcc -o solution lex.yy.c -lfl && ./solution < input.txt"
#include <stdio.h>
int abs(int);
int distance(int, int, int);
int max(int, int);

int max_distance = 0;
int x = 0;
int y = 0;
int z = 0;
%}

%%
n  y++, z--;
s  y--, z++;
ne x++, z--;
nw x--, y++;
se x++, y--;
sw x--, z++;
, max_distance = max(max_distance, distance(x, y, z));
%%

int abs(int x) {
  return (x > 0 ? x : -x);
}

int distance(int x, int y, int z) {
  return (abs(x) + abs(y) + abs(z)) / 2;
}

int max(int a, int b) {
  return (a > b) ? a : b;
}

int main() {
  yylex();
  printf("Part 1: %d\n", distance(x, y, z));
  printf("Part 2: %d\n", max_distance);
}
