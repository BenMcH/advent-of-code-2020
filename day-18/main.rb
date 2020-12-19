problems = File.read('./data.txt').split("\n").map{|problem| problem.gsub(' ', '')}

def break_down_problem(problem, start_index = 0)
    prob = []
    skip_til = -1
    problem.chars[start_index..-1].each.with_index do |char, idx|
        index = start_index + idx
        next if index < skip_til
        if '(' == char
            p, skip_til = break_down_problem(problem, index + 1)
            prob << p
        elsif ')' == char
            return prob, index + 1
        else
            prob << (char.to_i > 0 ? char.to_i : char)
        end
    end

    return prob, -1
end

def solve_problem(problem)
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

class Integer
    def -(operator)
        self * operator
    end
end

p problems.map{ |prob| eval(prob.gsub('*', '-')) }.sum

class Integer
    def -(operator)
        self * operator
    end

    def /(operator)
        self + operator
    end
end

p problems.map{ |prob| eval(prob.gsub('*', '-').gsub('+', '/')) }.sum
