use std::io::{self, BufRead};
use std::collections::HashMap;
use std::sync::mpsc::{Sender, Receiver};
use std::sync::mpsc;
use std::time::Duration;
use std::thread;

type Result<T> = ::std::result::Result<T, Box<dyn (::std::error::Error)>>;

#[derive(Clone, Debug)]
struct Instruction {
    op: String,
    register: String,
    value: String,
}

fn parse_input() -> Vec<Instruction> {
    let stdin = io::stdin();
    let iterator = stdin.lock().lines();
    let mut instructions = vec![];

    for line in iterator {
        let line_here = line.unwrap();
        let instr = line_here.split(" ").collect::<Vec<_>>();

        let mut instruction = Instruction {
            op: instr[0].to_string(),
            register: instr[1].to_string(),
            value: "".to_string(),
        };

        if instr.len() > 2 {
            instruction.value = instr[2].to_string()
        }
        instructions.push(instruction);
    }
    return instructions;
}


fn exec_instructions(instructions: &Vec<Instruction>) -> i64 {
    let mut registers = HashMap::new();

    let mut ip = 0;
    let mut last_played_sound = -1;
    while ip < instructions.len() {
        let instruction = &instructions[ip as usize];
        let op = &instruction.op;
        let register = &instruction.register;
        let value = &instruction.value;
        let mut value_val = -1i64;
        let mut ip_jump = 1i64;

        let register_val = *registers.entry(&register[..]).or_insert(0);

        if value != "" {
            value_val = match value.parse::<i64>() {
                Ok(n) => n,
                Err(_) => *registers.entry(&value[..]).or_insert(0),
            };
        }

        match &op[..] {
            "snd" => {
                last_played_sound = register_val;
            },
            "set" => {
                registers.insert(&register[..], value_val);
            },
            "add" => {
                registers.insert(&register[..], register_val + value_val);
            },
            "mul" => {
                registers.insert(&register[..], register_val * value_val);
            },
            "mod" => {
                registers.insert(&register[..], register_val % value_val);
            },
            "rcv" => {
                if register_val != 0 {
                    return last_played_sound;
                }
                registers.insert(&register[..], register_val);
            },
            "jgz" => {
                if register_val > 0 {
                    ip_jump = value_val;
                }
            },

            _ => {}
        }

        ip = (ip as i64 + ip_jump) as usize;
    }
    return -1;
}


fn exec_instructions2(instructions: Vec<Instruction>, channel: i32, tx: Sender<i64>, rx:Receiver<i64>) -> i64 {
    let mut registers = HashMap::new();
    registers.insert("p", channel as i64);
    let mut ip = 0;
    let mut snd_count = 0;

    while ip < instructions.len() {
        let instruction = &instructions[ip as usize];
        let op = &instruction.op;
        let register = &instruction.register;
        let value = &instruction.value;
        let mut value_val = -1i64;
        let mut ip_jump = 1i64;

        let register_val = match register.parse::<i64>() {
            Ok(n) => n,
            Err(_) => *registers.entry(&register[..]).or_insert(0),
        };
        if value != "" {
            value_val = match value.parse::<i64>() {
                Ok(n) => n,
                Err(_) => *registers.entry(&value[..]).or_insert(0),
            };
        }

        match &op[..] {
            "set" => {
                registers.insert(&register[..], value_val);
            },
            "add" => {
                registers.insert(&register[..], register_val + value_val);
            },
            "mul" => {
                registers.insert(&register[..], register_val * value_val);
            },
            "mod" => {
                registers.insert(&register[..], register_val % value_val);
            },
            "snd" => {
                tx.send(register_val).unwrap();
                snd_count+=1;
            },
            "rcv" => {
                let rec_val = match rx.recv_timeout(Duration::from_millis(400)) {
                    Ok(x) => x,
                    Err(_) => {
                        if channel == 1 {
                            println!("Part 2: {}", snd_count);
                        }
                        break;
                    },
                };

                registers.insert(&register[..], rec_val);
            },
            "jgz" => {
                if register_val > 0 {
                    ip_jump = value_val;
                }
            },

            _ => {}
        }

        ip = (ip as i64 + ip_jump) as usize;
    }
    return -1;
}


fn main() -> Result<()> {
    let instructions = parse_input();
    part1(&instructions);
    part2(instructions);
    Ok(())
}

fn part1(instructions: &Vec<Instruction>) {
    let part1_sol = exec_instructions(instructions);
    println!("Part 1: {:?}", part1_sol);
}

fn part2(in1: Vec<Instruction>) {
    let (tx0, rx0) = mpsc::channel();
    let (tx1, rx1) = mpsc::channel();
    let in2 = in1.clone();

    let p0 = thread::spawn(move || {
        exec_instructions2(in1, 0, tx1, rx0);
    });
    let p1 = thread::spawn(move || {
        exec_instructions2(in2, 1, tx0, rx1);
    });
    p0.join().expect("p0 died");
    p1.join().expect("p1 died");
}
