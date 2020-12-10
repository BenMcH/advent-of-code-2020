jolts = File.read('./data.txt').split("\n").map(&:to_i).sort

differences = jolts.map.with_index { |jolt, index| index == 0 ? jolt : jolt - jolts[index-1] }
one_jolt_differences = differences.select{|diff| diff == 1}.length
three_jolt_differences = differences.select{|diff| diff == 3}.length + 1 # For your device

p one_jolt_differences * three_jolt_differences
