local program_map = {}
local has_group = {}
local first_group = {}
local result1 = 0
local result2 = 0

local function part1(prog)
    first_group[prog] = true
    result1 = result1 + 1
    local prog_ids = program_map[prog]
    for i = 1, #prog_ids do
        if not first_group[prog_ids[i]] then
            part1(prog_ids[i])
        end
    end
end

local function part2(prog)
    has_group[prog] = true
    local ids = program_map[prog]
    for i = 1, #ids do
        if not has_group[ids[i]] then
            part2(ids[i], group)
        end
    end
end


local f = io.open("input.txt", "r")

for line in f:lines() do
    local prog, instruction = line:match("(%d+) <%-> (.+)")
    local prog_ids = {}
    for id in instruction:gmatch("%d+") do
        prog_ids[#prog_ids+1] = id
    end
    program_map[prog] = prog_ids
end

f:close()

part1("0")
print("Part 1: ", result1)


for k, v in pairs(program_map) do
    if not has_group[k] then
        has_group[k] = true
        result2 = result2 + 1
    end
    for i = 1, #v do
        part2(v[i])
    end
end

print("Part 2: ", result2)
