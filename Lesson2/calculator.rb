# ask user for two numbers
# ask user for and operation to preform
# preform operation on the two numbers
# output result

# prompt so we dont have to add >> for each output to user
def prompt(message)
  puts ">> #{message}"
end

def integer?(input)
  input.to_i.to_s == input && amount.to_i > 0
end

def float?(input)
  input.to_f.to_s == input && amount.to_f > 0
end

def number?(input)
  (integer?(input) || float?(input)) && (amount.to_f > 0 || && amount.to_i > 0)
end

def operator_to_message(choice)
  case choice
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Muliplying'
  when '4'
    'Dividing'
  end
end

prompt 'Welcome to Calculator! Please enter your name: '

name = ''
loop do
  name = gets.chomp
  break unless name.empty?
end

prompt "Hi #{name}"

loop do # main loop
  number1 = '' # initialize outside of the loop so it is accessible
  loop do
    prompt 'What is the first number?'
    number1 = gets.chomp

    if integer?(number1)
      break
    elsif number?(number1)
      break
    else
      prompt "Hmm... that doesnt look like a valid number"
    end
  end

  number2 = ''
  loop do
    prompt "What is the second number?"
    number2 = gets.chomp
    if integer?(number2)
      break
    elsif
      number?(number2)
      break
    else
      prompt "Hmm... that doesnt look like a valid number"
    end
  end
  operator_prompt = <<-MSG
   "What operation would you like to preform?
  1) addition
  2) subtraction
  3) multiplication
  4) division"
  MSG

  prompt operator_prompt

  operator = ''
  loop do
    operator = gets.chomp
    if %w[1 2 3 4].include?(operator)
      break
    else
      prompt "Must put 1, 2, 3, or 4"
    end
  end

  prompt "#{operator_to_message(operator)} the two numbers..."

  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_i
           end

  prompt "The result is #{result}"
  prompt 'Do you want to preform another calculation?(Y to calculate again)'
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end
prompt 'Thank you for using calculator. Goodbye!'
