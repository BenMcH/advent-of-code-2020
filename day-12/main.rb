directions = File.read('./data.txt').split.map{|a| [a[0].downcase.to_sym, a[1..-1].to_i]}

N = [0, 1]
S = [0, -1]
E = [1, 0]
W = [-1, 0]

pos = [0, 0]
direction = [1, 0]

directions.each do |d|
    instruction, amount = d
    turns = amount / 90

    if instruction == :f
        pos = [pos[0] + direction[0] * amount, pos[1] + direction[1] * amount]
    end
    if instruction == :n
        pos[1] += amount
    end
    if instruction == :s
        pos[1] -= amount
    end
    if instruction == :e
        pos[0] += amount
    end
    if instruction == :w
        pos[0] -= amount
    end
    if instruction == :l
        turns.times do direction = direction == E ? N : direction == N ? W : direction == W ? S : E end
    end
    if instruction == :r
        turns.times do direction = direction == E ? S : direction == S ? W : direction == W ? N : E end
    end
end

p pos.map(&:abs).sum
