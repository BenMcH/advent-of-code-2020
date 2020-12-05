boarding_passes = File.read('./data.txt').split.map do |pass|
    [pass[0..6], pass[7..-1]]
end

def get_row(pass)
    rows = (0..127).to_a

    pass[0].chars.each do |fb|
        if fb == 'F'
            rows = rows.each_slice(rows.length / 2).to_a[0]
        else
            rows = rows.each_slice(rows.length / 2).to_a[1]
        end
    end

    rows[0]
end

def get_col(pass)
    cols = (0..7).to_a

    pass[1].chars.each do |lr|
        if lr == 'L'
            cols = cols.each_slice(cols.length / 2).to_a[0]
        else
            cols = cols.each_slice(cols.length / 2).to_a[1]
        end
    end

    cols[0]
end

def get_seat_id(row, col)
    row * 8 + col
end

all_seat_ids = boarding_passes.map{|pass| get_seat_id(get_row(pass), get_col(pass))}
max_seat_id = all_seat_ids.max
puts max_seat_id

missing_seat = max_seat_id
missing_seat = missing_seat - 1 while all_seat_ids.include?(missing_seat)

puts missing_seat
