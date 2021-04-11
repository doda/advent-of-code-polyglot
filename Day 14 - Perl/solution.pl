my $inp = "oundnydw";

my $part1 = 0;
my $part2 = 0;
my $board;
my %seen;

foreach my $row (0..127) {
    $$board [$row] = [];

    my $output = `echo "$inp-$row" | ./hash`;

    foreach my $char (split // => $output) {
        my $bitc = sprintf "%04b" => hex $char;
        push @{$$board [$row]} => split // => $bitc;
        $part1 += $bitc =~ y/1/1/;
    }
}

print("Part 1: $part1");


sub label {join "," => @_}

sub dfs {
    my ($i, $j) = @_;
    if ($$board [$i] [$j]) {
        my $ij = label ($i, $j);

        return if ($seen{$ij} == 1);
        $seen{$ij} = 1;
        if ($i > 0) { dfs($i - 1, $j); }
        if ($j > 0) { dfs($i, $j - 1); }
        if ($i < 127) { dfs($i + 1, $j); }
        if ($j < 127) { dfs($i, $j + 1); }
    }
}

foreach my $i (0..127) {
    foreach my $j (0..127) {
        if ($$board [$i] [$j]) {
            my $ij = label ($i, $j);
            next if ($seen{$ij} == 1);
            dfs($i, $j);
            $part2 += 1;
        }
    }
}

print("Part 2: $part2");
