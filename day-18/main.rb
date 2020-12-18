problems = File.read('./data.txt').split("\n").map{|problem| problem.gsub(' ', '')}

def break_down_problem(problem, start_index = 0)
    prob = []
    skip_til = -1
    problem.chars[start_index..-1].each.with_index do |char, idx|
        index = start_index + idx
        next if index < skip_til
        if '(' == char
            p, idx = break_down_problem(problem, index + 1)
            prob << p
            skip_til = idx
        elsif ')' == char
            return prob, index + 1
        else
            prob << (char.to_i > 0 ? char.to_i : char)
        end
    end

    return prob, -1
end

def solve_problem(problem)
    num = 0
    total = 0
    operator = :+
    problem.each do |i|
        if i.kind_of? Numeric
            total = total.send(operator, i) 
        elsif i.kind_of? Array
            total = total.send(operator, solve_problem(i)) 
        else
            operator = i.to_sym
        end
    end

    total
end

s = problems.map do |prob|
    broken_down = break_down_problem(prob)[0]
    solve_problem(broken_down)
end.sum

p s
