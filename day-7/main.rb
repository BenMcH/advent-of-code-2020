rules = File.read('./data.txt').split("\n").map{|rule| rule.gsub(/\s?[.,]\s?/, '').gsub(/\scontain\s/, '').strip.split(/ bags?/)}

def recursive_find(rules, starting_point, all_matches = [])
    matches = rules.map do |rule|
        any = rule.find{|line| line != rule[0] && line.include?(starting_point)}

        any ? rule[0] : nil
    end.keep_if{|a| a != nil}

    branching_rules = matches.flat_map{ |rule|
        recursive_find(rules, rule)
    }

    return matches.concat(branching_rules).uniq
end

puts recursive_find(rules, 'shiny gold').length

