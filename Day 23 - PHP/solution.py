from collections import defaultdict

import sys
mem = defaultdict(int)
instructions = [x.strip().split() for x in sys.stdin.readlines()]

ip = 0
mulled = 0

while ip >= 0 and ip < len(instructions):
    instruction= instructions[ip]
    action, a, b = instruction
    a_val = None
    b_val = None
    ipjump = 1

    if a.islower():
        a_val = mem[a]
    else:
        a_val = int(a)
    if b.islower():
        b_val = mem[b]
    else:
        b_val = int(b)

    if action == 'set':
        mem[a] = b_val
    elif action == 'sub':
        mem[a] -= b_val
    elif action == 'mul':
        mulled += 1
        mem[a] *= b_val
    elif action == 'jnz':
        if a_val:
            ipjump = b_val

    ip += ipjump

    
print("Part 1:", mulled)

b, h = 107900, 0
for x in range(b, b + 17000 + 1, 17):
    for i in range(2, x):
        if x % i == 0:
            h += 1
            break

print("Part 2:", h)