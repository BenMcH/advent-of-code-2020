passwords = File.read('./data.txt').split("\n")

good_passwords = passwords.keep_if do |pass|
    start_limit, end_limit, letter, password = /(\d+)-(\d+)\s*(\w):\s*(\w+)/.match(pass).captures
    start_limit, end_limit = start_limit.to_i, end_limit.to_i
    password = password.gsub(/[^#{letter}]/, '')

    (start_limit..end_limit).include?(password.length)
end

puts good_passwords.length
