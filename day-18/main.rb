problems = File.read('./data.txt').split("\n").map{|problem| problem.gsub(' ', '')}

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
