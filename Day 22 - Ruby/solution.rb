def rotright(x, y)
    return y, -x
end

def rotleft(x, y)
    rotright(*rotright(*rotright(x, y)))
end

def part1(grid, maxi, maxj) 
    iter = 10000
    x, y = maxi / 2, maxj / 2
    dirx, diry = -1, 0
    infected = 0
    for i in 0...iter do
        cur_node = grid[[x, y]]
        if cur_node == '#'
            grid[[x, y]] = '.'
            dirx, diry = rotright(dirx, diry)
        elsif cur_node == '.'
            infected += 1
            grid[[x, y]] = '#'
            dirx, diry = rotleft(dirx, diry)
        end
        x += dirx
        y += diry
    end
    infected
end

def part2(grid, maxi, maxj) 
    iter = 10000000
    x, y = maxi / 2, maxj / 2
    dirx, diry = -1, 0
    infected = 0
    for i in 0...iter do
        cur_node = grid[[x, y]]
        if cur_node == '.'
            dirx, diry = rotleft(dirx, diry)
            grid[[x, y]] = 'W'
        elsif cur_node == 'W'
            infected += 1
            grid[[x, y]] = '#'
        elsif cur_node == '#'
            dirx, diry = rotright(dirx, diry)
            grid[[x, y]] = 'F'
        elsif cur_node == 'F'
            dirx, diry = rotright(dirx, diry)
            dirx, diry = rotright(dirx, diry)
            grid[[x, y]] = '.'
        end
        x += dirx
        y += diry
    end
    infected
end

def main() 
    grid = Hash.new('.')
    i = 0
    maxi = 0
    maxj = 0
    ARGF.each do |line|
        line = line.strip
        for j in 0...line.length
            grid[[i, j]] = line[j].chr
            maxi = [i, maxi].max
            maxj = [j, maxj].max
        end
        i += 1
    end
    infected = part1(grid.clone, maxi, maxj)
    puts "Part 1: #{infected}"
    infected = part2(grid.clone, maxi, maxj)
    puts "Part 2: #{infected}"
end

main()
