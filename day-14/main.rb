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

memory = init(sets)

p memory.values.sum
