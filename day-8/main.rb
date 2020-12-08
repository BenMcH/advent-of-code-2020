instructions = File.read('data.txt').split("\n").map(&:split).map{|instruction| [instruction[0], instruction[1].to_i]}

run_instructions = []
acc = 0
program_counter = 0

while !run_instructions.include?(program_counter)
    instruction, argument = instructions[program_counter]

    case instruction
    when 'acc'
        acc += argument
    when 'jmp'
        program_counter += (argument - 1)
    end

    run_instructions << program_counter
    program_counter += 1
end

puts acc
