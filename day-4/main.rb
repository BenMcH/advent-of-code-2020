# Split passport data into 2d array. First dimension: Passports, Second dimension: Properties
passport_data = File.read("./data.txt").split("\n\n").map(&:split)

required_fields_part_1 = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

valid_passports_pt_1 = passport_data.select do |passport|
    fields = passport.map{|field| field[0..2]}

    required_fields_part_1.all? {|field| fields.include? field}
end

puts valid_passports_pt_1.length
