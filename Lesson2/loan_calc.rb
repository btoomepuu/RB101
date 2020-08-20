# program to calculate monthly loan payment
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
    prompt 'Please enter your loan amount.'
    loan = gets.chomp.delete ","
    if number?(loan)
      loan = loan.to_f
      break loan
    else
      prompt 'Please enter a positive number value.'
      puts ''
    end
  end
end

def get_arp
  loop do
    prompt 'Please enter your APR.(ex. for 6.5% enter 6.5)'
    arp = gets.chomp
    if number?(arp)
      arp = (arp.to_f / 12) * 10**-2
      break arp
    else
      prompt 'Please enter a positive number value'
      puts ''
    end
  end
end

def months_or_years
  loop do
    prompt 'Is the loan duration in months or years? Please enter
    months or years.'
    duration_input = gets.chomp.downcase
    if duration_input == 'months'
      break duration_input
    elsif duration_input == 'years'
      break duration_input
    else
      prompt 'Please enter months or years'
      puts ''
    end
  end
end

def get_duration_months(duration_input)
  loop do
    case duration_input
    when 'months'
      prompt 'How many months?'
      months = gets.chomp
      if integer?(months)
        break months.to_i
      else
        prompt 'Please enter a positive number value.'
      end
    when 'years'
      prompt 'How many years?'
      years = gets.chomp
      if integer?(years)
        break years.to_i * 12
      else
        prompt 'Please enter a positive number value.'
        puts ''
      end
    end
  end
end

prompt 'Welcome to Loan Calculator! Please enter your name: '

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

  prompt 'Would you like to enter a new loan? (y/n)'
  answer = gets.chomp.downcase
  break unless answer == 'y'
end

prompt "Thank you for using Loan Calculator, #{name}."
prompt 'Goodbye!'
