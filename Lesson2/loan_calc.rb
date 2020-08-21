# program to calculate monthly loan payment
require "pry"
require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

def prompt(message)
  puts ">>#{message}"
end

def integer?(input)
  input.to_i.to_s == input && input.to_i > 0
end

def float?(input)
  input.to_f.to_s == input && input.to_f > 0
end

def number?(input)
  float?(input) || integer?(input)
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
  prompt(MESSAGES['months_years'])
  loop do
    duration_input = gets.chomp.downcase
    if duration_input == 'months'
      break duration_input
    elsif duration_input == 'years'
      break duration_input
    else
      prompt(MESSAGES['valid_month_year'])
    end
  end
end

def get_duration_months(duration_input)
  time = ''
  loop do
    prompt "How many #{duration_input}?"
    time = gets.chomp
    if integer?(time)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end
  duration_input == "months" ? time.to_i : time.to_i * 12
end

def get_monthly_payment(loan, arp, duration)
  (loan * (arp / (1 - (1 + arp)**-duration))).round(2)
end

def valid_new_loan
  answer = ''
  loop do
    prompt(MESSAGES['new_loan'])
    answer = gets.chomp
    if answer == 'y'
      clear_screen
      break
    elsif answer == 'n'
      break
    else
      prompt(MESSAGES['new_loan_responce'])
    end
  end
  answer
end

def clear_screen
  system('clear') || system('cls')
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp.strip.capitalize
  break unless name.empty?
  prompt(MESSAGES['valid_name'])
end

prompt "Welcome #{name}"
puts ''

loop do
  loan = get_loan_amount
  arp = get_arp
  duration = get_duration_months(months_or_years)
  monthly_payment = get_monthly_payment(loan, arp, duration)
  prompt "Your monthly payment will be #{monthly_payment}."
  break if valid_new_loan == 'n'
end

prompt "Thank you for using Loan Calculator, #{name}."
puts ''
prompt 'Goodbye!'
