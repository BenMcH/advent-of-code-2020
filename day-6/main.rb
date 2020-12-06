groups = File.read('./data.txt').split("\n\n")

puts groups.map{|group| group.gsub(/[^a-z]/, '')}.map(&:chars).map(&:uniq).map(&:length).reduce(&:+)
