boarding_passes = File.read('./data.txt').split.map do |pass|
    [pass[0..6], pass[7..-1]]
end

def get_pos(max, instructions, upper_char)
    ids = (0..max).to_a

    instructions.chars.each do |upper_lower|
        upper_half, lower_half = ids.each_slice(ids.length / 2).to_a
        ids = upper_lower == upper_char ? upper_half : lower_half
    end

    ids[0]
end

def get_seat_id(row, col)
    row * 8 + col
end

all_seat_ids = boarding_passes.map{|pass| get_seat_id(get_pos(127, pass[0], 'F'), get_pos(7, pass[1], 'L'))}
max_seat_id = all_seat_ids.max
puts max_seat_id

missing_seat = max_seat_id
missing_seat = missing_seat - 1 while all_seat_ids.include?(missing_seat)

puts missing_seat
