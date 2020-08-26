#Repeat Yourself
def repeat_string (number, string)
  number = number.to_i
  number.times {puts string}
end

#Odd
def is_odd?(integer)
  integer.abs.odd?
end


#List of Digits
def num_to_array(number)
    num_array = number.digits
end

p num_to_array(9030828)

def digit_list(number)
  number.to_s.chars.map(&:to_i)
end
p digit_list(9090909)
#(&:to_i) short for something.map { |char| char.to_i }

#How Many?

def count_occurrences(vehicles)
  v_hash = {}
  vehicles.each do |v|  
    v_hash[v] += 1
  end
  v_hash.each_pair {|key, value|  puts "#{key} => #{value}"}
end 
vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

def count_occurrences(array)
  occurrences = {}

  array.uniq.each do |element|
    occurrences[element] = array.count(element)
  end

  occurrences.each do |element, count|
    puts "#{element} => #{count}"
  end
end

count_occurrences(vehicles)

#Reverse It Part1

def reverse_sentence(string)
  string = string.lines(' ').reverse.collect { |x| x + ' '}
  p string
  reverse_string = ''
 string.each do |word|
   reverse_string << (' ' + word).rstrip
 end 
 p reverse_string.strip
end

def reverse_sentence(string)
  string.split.reverse.join(' ')
end

puts reverse_sentence('') == ''
puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'