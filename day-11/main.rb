seats = File.read('./data.txt').split.map{|line| line.split('') }

$states = {
    FLOOR: '.',
    EMPTY: 'L',
    TAKEN: '#'
}

$directions = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1],
]

def count_neighbors(game_board, y, x)
    $directions.map do |direction|
        new_y, new_x = y + direction[0], x + direction[1]
        if new_y < 0 || new_y >= game_board.length || new_x < 0 || new_x >= game_board[y].length
            0
        else
            game_board[new_y][new_x] == '#' ? 1 : 0
        end
    end.sum
end

board = seats.dup
while true
    new_board = board.map.with_index do |line, y|
        line.map.with_index do |seat, x|
            neighbors = count_neighbors(board, y, x)

            if seat == $states[:FLOOR]
                seat
            elsif seat == $states[:EMPTY]
                neighbors == 0 ? $states[:TAKEN] : seat
            else
                neighbors >= 4 ? $states[:EMPTY] : seat
            end
        end
    end

    break if new_board == board
    board = new_board
end

p board.map {|row| row.count{|seat| seat == $states[:TAKEN] }}.sum

def count_far_neighbors(game_board, y, x)
    $directions.map do |direction|
        new_y, new_x = y + direction[0], x + direction[1]
        new_y, new_x = new_y + direction[0], new_x + direction[1] while (0..game_board.length - 1).include?(new_y) && (0..game_board[new_y].length - 1).include?(new_x) && game_board[new_y][new_x] == $states[:FLOOR]
        if new_y < 0 || new_y >= game_board.length || new_x < 0 || new_x >= game_board[y].length
            0
        else
            game_board[new_y][new_x] == '#' ? 1 : 0
        end
    end.sum
end

board = seats.dup
while true
    new_board = board.map.with_index do |line, y|
        line.map.with_index do |seat, x|
            neighbors = count_far_neighbors(board, y, x)

            if seat == $states[:FLOOR]
                seat
            elsif seat == $states[:EMPTY]
                neighbors == 0 ? $states[:TAKEN] : seat
            else
                neighbors >= 5 ? $states[:EMPTY] : seat
            end
        end
    end

    break if new_board == board
    board = new_board
end

p board.map {|row| row.count{|seat| seat == $states[:TAKEN] }}.sum
