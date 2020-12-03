forest_map = File.read('./data.txt').split("\n")

trees_encountered_part_1 = forest_map.each_with_index.map do |row, idx|
    row[(idx * 3) % row.length] == '#' ? 1 : 0
end.reduce(&:+)

puts trees_encountered_part_1

