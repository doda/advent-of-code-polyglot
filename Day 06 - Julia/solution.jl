function solve()
    numbers = readline()
    nums = map(x->parse(Int32,x), split(numbers, " "))

    seen = Dict()
    steps = 0

    while true
        if haskey(seen, nums)
            break
        end
        numscopy = copy(nums)
        seen[numscopy] = steps
        highest = argmax(nums)
        num = nums[highest]
        nums[highest] = 0
        for rem=highest+1:highest+num
            addto = mod1(rem, length(nums))
            nums[addto] += 1
        end
        steps += 1
    end
    println("Part 1: ", steps)
    println("Part 2: ", steps-seen[nums])
end

solve()