data = File.read('./data.txt').split("\n\n")

tiles = {}
tile_edges = {}
data.each do |t|
    name, *tt = t.split("\n")

    key = name[5..-2].to_i
    tiles[key] = tt
    tile_edges[key] = [
        tt[0],
        tt[-1],
        tt.map{|c| c[0]}.join,
        tt.map{|c| c[-1]}.join,
    ]
    tile_edges[key].concat tile_edges[key].map(&:reverse)
end

c = tile_edges.to_a.map do |tile_entry|
    [
        tile_entry[0],
        tile_entry[1][0..3].map{|edge| tile_edges.flat_map{|c| c[1]}.count{|c| c == edge}}.select{|c| c == 1}.length
    ]
end.select{|c| c[1] == 2}


p c.map{|b|b[0]}.reduce(&:*)
