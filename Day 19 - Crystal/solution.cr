def print_grid(grid : Array(String), i : Int, j : Int)
    tmp = grid[i][j]
    grid[i] = grid[i].sub(j, 'X')
    grid.each do |x|
        puts x
    end
    grid[i] = grid[i].sub(j, tmp)
end

def main() 
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    result = [] of Char
    
    arr = [] of String
    STDIN.each_line do |line|
        arr << " " + line +  " "
    end
    
    wide = arr[0].size
    
    arr << " " * wide
    arr.insert(0, " " * wide)
    
    i, steps = 1, 0
    wide = arr[0].size
    tall = arr.size
    j = arr[i].index("|")
    
    if !j
        return 
    end
    
    di, dj = 1, 0
    while i >= 0 && i < tall && j >= 0 && j < wide
        cur_char = arr[i][j]
        if cur_char == ' '
            break
        end
        if chars.includes?(cur_char)
            result << cur_char
        end
    
        if cur_char == '+'
            up_char = arr[i-1][j]
            right_char = arr[i][j+1]
            left_char = arr[i][j-1]
            down_char = arr[i+1][j]
    
            if (up_char == '|' || chars.includes?(up_char)) && di != 1 && dj != 0
                di, dj = -1, 0
            elsif (right_char == '-' || chars.includes?(right_char)) && di != 0 && dj != -1
                di, dj = 0, 1
            elsif (left_char == '-' || chars.includes?(left_char)) && di != 0 && dj != 1
                di, dj = 0, -1
            elsif (down_char == '|' || chars.includes?(down_char)) && di != -1 && dj != 0
                di, dj = 1, 0
            end
        end
    
        i += di
        j += dj
        steps += 1
    end
    
    puts "Part 1: #{result.join("")}"
    puts "Part 2: #{steps}"    
end

main()
