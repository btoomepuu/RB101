
=begin
counter = 0

loop do
  counter += 1
  binding.pry # execution will stop here
  break if counter == 5
end


def integer?(input)
  input.to_i.to_s == input && input.to_i > 0
end

def float?(input)
  if input.end_with?('0')
    input = input.delete_suffix('0')
  end 
  input.to_f.to_s == input && input.to_f > 0
end

def number?(input)
  integer?(input) || float?(input)
end 


p number?('10000.90')
p number?('18980.00')
p number?('8.9')
p float?('1000000.99')
=end 

def loan_amount
  loop do
    puts "please enter amount"
    amount = gets.chomp
    if amount.to_f > 0 
      amount = amount.to_f
      break
    else 
      puts 'enter a number value'
    end 
  end 
end 

loan = loan_amount