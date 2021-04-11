import std.algorithm, std.array, std.conv, std.range, std.stdio, std.string;

void solve(int[] seq, bool part1)
{
    auto arr = 256.iota.array;
    auto cycle = arr.cycle;
    int reps = 1;
    int skip = 0;

    if (!part1)
    {
        reps = 64;
        seq ~= [17, 31, 73, 47, 23];
    }

    foreach (rep; 0 .. reps)
        foreach (i; seq)
        {
            reverse(cycle[0 .. i]);
            cycle = cycle.drop(i + skip);
            skip += 1;
        }

    if (part1)
    {
        writeln("Part 1: ", arr[0] * arr[1]);
    }
    else
    {
        auto hash = arr.chunks(16).map!(x => x.reduce!(q{a ^ b})).array;
        writefln("Part 2: %(%02x%)", hash);
    }
}

void main()
{
    auto inp = readln.strip();
    auto nums = inp.split(",").map!(to!(int)).array;
    auto bytes = inp.map!(x => cast(int)(x)).array;
    solve(nums, true);
    solve(bytes, false);
}
