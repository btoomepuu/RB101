=begin
def prompt(message)
  Kernel.puts("=> #{message}")
end

loop do
  prompt("Welcome to Mortgage Calculator!")
  prompt("-------------------------------")

  prompt("What is the loan amount?")

  amount = ''
  loop do
    amount = Kernel.gets().chomp()

    if amount.empty?() || amount.to_f() < 0
      prompt("Must enter positive number.")
    else
      break
    end
  end

  prompt("What is the interest rate?")
  prompt("(Example: 5 for 5% or 2.5 for 2.5%)")

  interest_rate = ''
  loop do
    interest_rate = Kernel.gets().chomp()

    if interest_rate.empty?() || interest_rate.to_f() < 0
      prompt("Must enter positive number.")
    else
      break
    end
  end

  prompt("What is the loan duration (in years)?")

  years = ''
  loop do
    years = Kernel.gets().chomp()

    if years.empty?() || years.to_i() < 0
      prompt("Enter a valid number")
    else
      break
    end
  end

  annual_interest_rate = interest_rate.to_f() / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = years.to_i() * 12

  monthly_payment = amount.to_f() *
                    (monthly_interest_rate /
                    (1 - (1 + monthly_interest_rate)**(-months)))

  prompt("Your monthly payment is: $#{format('%.2f', monthly_payment)}")

  prompt("Another calculation?")
  answer = Kernel.gets().chomp()

  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the Mortgage Calculator!")
prompt("Good bye!")
=end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

-------------------------------------------



def yr_to_mon_interest(interest)
  (interest.to_f / 12) * 10**-2
end

def year_to_months(years)
  years * 12
end



loan_amount = ''
loop do
  prompt 'Enter loan amount: '
  loan_amount = gets.chomp
  if integer?(loan_amount) && (loan_amount.to_i).positive?
    break
  elsif float?(loan_amount)
    break
  else
    prompt 'Please enter a positive number value.'
  end
end
loan_amount = loan_amount.to_f

interest_apr = ''
loop do
  prompt 'Enter apr: '
  prompt("(Example: 5 for 5% or 2.5 for 2.5%)")
  interest_apr = gets.chomp
  if integer?(interest_apr) 
    break
  elsif float?(interest_apr)
    break
  else
    prompt 'Please enter a positive number value.'
  end
end
interest_monthly = yr_to_mon_interest(interest_apr)

term_months = ''
term_option = ''
loop do
  loan_term_prompt = <<-MSG
  "Is the loan term in years or months?"
  1) months
  2) years
  MSG

  prompt loan_term_prompt

  term_option = gets.chomp
  if %w[1 2].include?(term_option)
  else
    puts ' Must enter 1 or 2.'
  end

  prompt 'What is the duration of the loan?'
  term_months = gets.chomp
  if integer?(term_months)
  elsif float?(term_months)
  else
    prompt 'Please enter a positive number value.'
  end

  if term_option == '1'
    term_months = term_months.to_f
  else
    term_months = year_to_months(term_months.to_f)
  end
  break
end

monthly_payment = (loan_amount * (interest_monthly /
                  (1 - (1 + interest_monthly)**(-term_months)))).round(2)

prompt("Your monthly payment is: $#{monthly_payment}")

prompt("Thank you for using the Mortgage Calculator!")

prompt("Good bye!")
