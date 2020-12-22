hand_one, hand_two = File.read('./data.txt').split("\n\n").map{|hand| hand.split("\n")[1..-1].map(&:to_i)}

h1 = hand_one.dup
h2 = hand_two.dup

until h1.length == 0 || h2.length == 0
    p1, *p1_l = h1
    p2, *p2_l = h2
    
    if p1 > p2
        h1 = [*p1_l, p1, p2]
        h2 = p2_l
    else
        h2 = [*p2_l, p2, p1]
        h1 = p1_l
    end
end

hand = h1.length > 0 ? h1 : h2

p hand.reverse.map.with_index{|n, i| n * (i + 1)}.sum
