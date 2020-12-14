sets = File.read("./data.txt").split("mask").select{|line| line.include?("\n")}.map{|set| "mask#{set}".split("\n")}

def init(sets)
    memory = {}
    sets.each do |set|
        mask, *rules = set
        mask = mask[7..-1]

        rules.each do |rule|
            index, value = /mem\[(\d+)\] = (\d+)/.match(rule).captures
            index, value = index.to_i, value.to_i.to_s(2).rjust(36, '0')

            mask.chars.each.with_index do |m, idx|
                next if m == 'X'
                value[idx] = m
            end

            memory[index] = value.to_i(2)
        end
    end

    memory
end

p init(sets).values.sum

def create_indexes(mask, index)
    pairs = mask.chars.map.with_index{|c, i| [c, i]}.select{|c| c[0] == 'X'}
    start, *others = mask.chars.map.with_index do |m, i|
        if m == '1'
            [1]
        elsif m == 'X'
            [0, 1]
        else
            [index[i]]
        end
    end

    start.product(*others).map(&:join)
end

def init_part_2(sets)
    memory = {}
    sets.each do |set|
        _mask, *rules = set
        mask = _mask[7..-1]

        rules.each do |rule|
            index, value = /mem\[(\d+)\] = (\d+)/.match(rule).captures
            index, value = index.to_i.to_s(2).rjust(36, '0'), value.to_i

            create_indexes(mask, index).each do |index|
                memory[index.to_i(2)] = value
            end
        end
    end

    memory
end

p init_part_2(sets).values.sum
