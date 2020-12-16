criteria, my_ticket, nearby_tickets = File.read('./data.txt').split("\n\n")
my_ticket = my_ticket[1]
_, *nearby_tickets = nearby_tickets.split("\n")

rules = []
criteria.split("\n").each do |crt|
    x1, x2, y1, y2 = /.*: (\d+)-(\d+) or (\d+)-(\d+)/.match(crt).captures

    rules << [(x1.to_i..x2.to_i), (y1.to_i..y2.to_i)]
end

nearby_tickets = nearby_tickets.map do |ticket|
    ticket.split(',').map(&:to_i)
end

flat_rules = rules.flatten

p nearby_tickets.flatten.select{|field| flat_rules.none?{|rule| rule.include? field }}.sum
