import sys
from collections import defaultdict

d = defaultdict(list)

components = [(
    i,
    int(x.strip().split('/')[0]),
    int(x.strip().split('/')[1]),
) for i, x in enumerate(sys.stdin.readlines())]

for comp in components:
    i, a, b = comp
    d[a].append(comp)
    d[b].append(comp)

used_components = set()
BIG_NUM = 1000000
def recurse(port_needed, part2=False):
    possible_components = [
        x for x in d[port_needed] if not x[0] in used_components
    ]
    max_found = 0
    for next_id, next_a, next_b in possible_components:
        used_components.add(next_id)
        
        if port_needed == next_a:
            next_port_needed = next_b
        else:
            next_port_needed = next_a

        max_for_this_part = recurse(next_port_needed, part2) + next_a + next_b + (BIG_NUM * part2)
        max_found = max(max_for_this_part, max_found)
        used_components.remove(next_id)
    return max_found


print("Part 1:", recurse(0))
print("Part 2:", recurse(0, True) % BIG_NUM)