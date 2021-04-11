import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class Solution {
    public static String read() {
        try {
            File file = new File("input.txt");
            return new Scanner(file).nextLine();
        } catch (FileNotFoundException e) {
            return "";
        }
    }    

    private static String dance(String[] input, char[] programs, long reps) {
        List<String> seen = new ArrayList<>();
        for (long i = 0; i < reps; i++) {
            String ps = new String(programs);
			if (seen.contains(ps)) {
                int index = (int) (reps % i);
                return seen.get(index);
            }
            seen.add(ps);
            
            int len = programs.length;
            StringBuilder sb = new StringBuilder(new String(programs));
            Arrays.stream(input).forEach(instruction -> {
                char action = instruction.charAt(0);
                if (action == 's') {
                    Integer spin = Integer.valueOf(instruction.substring(1, instruction.length()));
                    String s = sb.toString();
                    sb.replace(0, len, new String(s.substring(len - spin, len) + s.substring(0, len - spin)));
                } else if (action == 'x') {
                    String[] tokens = instruction.substring(1, instruction.length()).split("/");
                    Integer a = Integer.valueOf(tokens[0]);
                    Integer b = Integer.valueOf(tokens[1]);
                    char va = sb.charAt(a);
                    sb.setCharAt(a, sb.charAt(b));
                    sb.setCharAt(b, va);
                } else if (action == 'p') {
                    String[] tokens = instruction.substring(1, instruction.length()).split("/");
                    char va = tokens[0].charAt(0);
                    char vb = tokens[1].charAt(0);
                    int a = sb.indexOf(Character.toString(va));
                    int b = sb.indexOf(Character.toString(vb));
                    sb.setCharAt(a, vb);
                    sb.setCharAt(b, va);
            }
            });
            programs = sb.toString().toCharArray();
            
        }
        return new String(programs);
    }

    public static void main(String[] args) {
        String[] input = read().split(",");
		String programs = "abcdefghijklmnop";

        System.out.printf("Part 1: %s\n", dance(input, programs.toCharArray(), 1));
        System.out.printf("Part 2: %s\n", dance(input, programs.toCharArray(), 1000000000));
    }
}
