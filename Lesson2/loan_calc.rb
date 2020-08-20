# program to calculate monthly loan payment

require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

def prompt(message)
  puts ">>#{message}"
end

def integer?(input)
  input.to_i.to_s == input && input.to_i > 0
end

def number?(input)
  input.to_f > 0
end

def get_loan_amount
  loop do
    prompt(MESSAGES['loan_amount'])
    loan = gets.chomp.delete ","
    if number?(loan)
      loan = loan.to_f
      break loan
    else
      prompt(MESSAGES['valid_number'])
      puts ''
    end
  end
end

def get_arp
  loop do
    prompt prompt(MESSAGES['get_apr'])
    arp = gets.chomp
    if number?(arp)
      arp = (arp.to_f / 12) * 10**-2
      break arp
    else
      prompt(MESSAGES['valid_number'])
      puts ''
    end
  end
end

def months_or_years
  loop do
    prompt(MESSAGES['months_years'])
    duration_input = gets.chomp.downcase
    if duration_input == 'months'
      break duration_input
    elsif duration_input == 'years'
      break duration_input
    else
      prompt(MESSAGES['valid_months_years'])
      puts ''
    end
  end
end

def get_duration_months(duration_input)
  time = ''
  loop do
    prompt "How many #{duration_input}?"
    time = gets.chomp
    if integer?(time)
      break time = time.to_i
    else
      prompt(MESSAGES['valid_number'])
    end
  end
  case duration_input
  when 'months'
    time = time
  when 'years'
    time *= 12
  end
  time
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp.strip.capitalize
  break unless name.empty?
end

prompt "Welcome #{name}"
puts ''

loop do
  loan = get_loan_amount
  arp = get_arp
  duration = get_duration_months(months_or_years)

  monthly_payment = (loan * (arp / (1 - (1 + arp)**-duration))).round(2)
  prompt "Your monthly payment will be #{monthly_payment}"
  puts ''

  prompt(MESSAGES['new_loan'])
  answer = gets.chomp.downcase
  break unless answer == 'y'
end

prompt "Thank you for using Loan Calculator, #{name}."
puts ''
prompt 'Goodbye!'
