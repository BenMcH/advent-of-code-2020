numbers = File.read('./data.txt').split("\n").map(&:to_i)

target = -1

numbers[25..-1].find.with_index do |number, index|
    preamble = numbers[index..(index+24)]
    sums = preamble.product(preamble).map{|set| set.reduce(&:+)}

    if sums.any?{|num| num == number}
        next
    end
    target = number
    break
end

puts target

start_index = 0
length = 0

numbers.each.with_index do |number, index|
    start_index = index
    sum = number

    numbers[index+1..-1].each.with_index do |another_one, another_index|
        length = another_index + 1
        sum += another_one

        if sum >= target
            break
        end
    end
    if sum == target
        break
    end
end

arr = numbers[start_index..start_index+length]

puts arr.min + arr.max
