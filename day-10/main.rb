jolts = File.read('./data.txt').split("\n").map(&:to_i).sort

differences = jolts.map.with_index { |jolt, index| index == 0 ? jolt : jolt - jolts[index-1] }
one_jolt_differences = differences.select{|diff| diff == 1}.length
three_jolt_differences = differences.select{|diff| diff == 3}.length + 1 # For your device

p one_jolt_differences * three_jolt_differences

graph = {}
jolts << jolts[-1] + 3

$memo = {}
def fill_graph(parent, graph, jolts)
    if $memo[parent]
        graph[parent] = $memo[parent]
    else
        graph[parent] = jolts.select{|j| (1..3).include?(j - parent)}
        graph[parent].each do |jolt|
            fill_graph(jolt, graph, jolts.select{|j| j > jolt})
        end
        $memo[parent] = graph[parent].dup
    end

    graph
end

fill_graph(0, graph, jolts)

$memo = {}
def count_possibilities(graph_a, number)
    unless $memo[number]
        $memo[number] = number == graph_a[-1][0] ? 1 : graph_a.find{|a| a[0] == number}[1].map{|a| count_possibilities(graph_a, a)}.sum
    end
    
    return $memo[number]
end

p count_possibilities(graph.to_a, 0)


