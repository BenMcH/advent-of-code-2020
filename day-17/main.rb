slice = File.read('data.txt').split("\n").map{|row| row.split('')}

board = {}
board[0] = {}
slice.each.with_index do |row, y|
    board[0][y] = {}
    row.each.with_index do |col, x|
        board[0][y][x] = col == '#'
    end
end

def list_neighbors(x, y, z)
    xs = (x-1..x+1).to_a
    ys = (y-1..y+1).to_a
    zs = (z-1..z+1).to_a

    xs.product(ys, zs) - [[x, y, z]]
end

def count_active_neighbors(x, y, z, board)
    count = 0
    list_neighbors(x, y, z).each do |loc|
        count += 1 if board[loc[2]] && board[loc[2]][loc[1]] && board[loc[2]][loc[1]][loc[0]]
    end

    count
end

6.times do
    new_board = {}

    z1, z2 = board.keys.minmax
    z1, z2 = z1 - 1, z2 + 1
    y1, y2 = board.values.flat_map{|row| row.keys.minmax }.minmax
    y1, y2 = y1 - 1, y2 + 1
    x1, x2 = board.values.flat_map{|row| row.values.flat_map {|col| col.keys.minmax} }.minmax
    x1, x2 = x1 - 1, x2 + 1
    (z1..z2).each do |z|
        new_board[z] = {}
        (y1..y2).each do |y|
            new_board[z][y] = {}
            (x1..x2).each do |x|
                neighbors = count_active_neighbors(x, y, z, board)

                new_board[z][y][x] = board[z] && board[z][y] && board[z][y][x] ? (2..3).include?(neighbors) : neighbors == 3
            end
        end
    end
    board = new_board
end


count = 0
board.values.each do |z|
    z.values.each do |row|
        row.values.each do |cell|
            count += 1 if cell
        end
    end
end

p count
