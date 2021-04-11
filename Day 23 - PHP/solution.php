<?php
$registers = [];
$get = function ($register) use (&$registers) {
    if (array_key_exists($register, $registers)) {
        return $registers[$register];
    } else {
        return 0;
    }
};

$instructions = [];
while ($line = fgets(STDIN)) {
    $instructions[] = rtrim($line);
}

$ip = 0;
$mulled = 0;
while ($ip < count($instructions)) {
    list($action, $a, $b) = explode(" ", $instructions[$ip]);
    $ipjump = 1;

    $a_val = $a;
    if (ctype_alpha($a)) {
        $a_val = $get($a);
    }

    $b_val = $b;
    if (ctype_alpha($b)) {
        $b_val = $get($b);
    }

    if ($action === "set") {
        $registers[$a] = $b_val;
    } else if ($action === "sub") {
        $registers[$a]-= $b_val;
    } else if ($action === "mul") {
        $mulled+= 1;
        $registers[$a]*= $b_val;
    } else if ($action === "jnz") {
        if ($a_val !== 0) {
            $ipjump = $b_val;
        }
    }
    $ip+= $ipjump;
}

echo "Part 1: $mulled\n";

$b = 107900;
$h = 0;
for ($x = $b;$x <= ($b + 17000);$x+= 17) {
    for ($e = 2;$e < $x;$e++) {
        if ($x % $e == 0) {
            $h++;
            break;
        }
    }
}

echo "Part 2: $h\n";
?>
