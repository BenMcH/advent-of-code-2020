criteria, my_ticket, nearby_tickets = File.read('./data.txt').split("\n\n")
my_ticket = my_ticket.split("\n")[1].split(',').map(&:to_i)
_, *nearby_tickets = nearby_tickets.split("\n")

rules = []
names = []
criteria.split("\n").each do |crt|
    name, x1, x2, y1, y2 = /(.*): (\d+)-(\d+) or (\d+)-(\d+)/.match(crt).captures

    names << name
    rules << [(x1.to_i..x2.to_i), (y1.to_i..y2.to_i)]
end

nearby_tickets = nearby_tickets.map do |ticket|
    ticket.split(',').map(&:to_i)
end

flat_rules = rules.flatten
invalid_fields = nearby_tickets.flatten.select{|field| flat_rules.none?{|rule| rule.include? field }}

p invalid_fields.sum

valid_tickets = nearby_tickets.select{|ticket| ticket.none?{|i| invalid_fields.include? i}}

columns = valid_tickets.transpose

column_rule_mapping = columns.map do |col|
    rules.select{|rule| col.all?{|v| rule.any?{|r| r.include? v}}}.map{|rule| rules.index(rule)}
end


until column_rule_mapping.none?{|c| c.kind_of?(Array)}
    r = column_rule_mapping.find{|a| a.kind_of?(Array) && a.length == 1}
    i = column_rule_mapping.index(r)
    column_rule_mapping[i] = r[0]
    column_rule_mapping.each.with_index do |rule, idx|
        if rule.kind_of?(Array)
            column_rule_mapping[idx] = column_rule_mapping[idx].select{|i| i != r[0]}
        end
    end
end

map = column_rule_mapping.map.with_index do |x, i|
    [names[x], i]
end

p map.select{|n| n[0].start_with? "depart"}.map{|name| my_ticket[name[1]]}.reduce(&:*)

