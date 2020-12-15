starting_numbers = [6,13,1,15,2,0]

numbers = [].concat(starting_numbers)

cache = {
    6 => 0,
    13 => 1,
    1 => 2,
    15 => 3,
    2 => 4,
    0 => 5,
}

(2020 - numbers.length).times do
    number = numbers[-1]
    idx = cache[number] || numbers.length - 1

    num = numbers.length - 1 - idx
    cache[number] = numbers.length - 1
    numbers << num
end

p numbers.length, numbers[-1]

(30000000 - numbers.length).times do
    number = numbers[-1]
    idx = cache[number] || numbers.length - 1

    num = numbers.length - 1 - idx
    cache[number] = numbers.length - 1
    numbers << num
end

p numbers.length, numbers[-1]
