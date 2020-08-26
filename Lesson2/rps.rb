require "pry"
require 'yaml'
MESSAGES = YAML.load_file('rps_messages.yml')

NEW_GAME_CHOICES = %w(r p ss l s)
WIN_SCORE = 5
WIN_OPTIONS = {
  "r" => ["ss", "l"],
  "p" => ["s", "r"],
  "ss" => ["l", "p"],
  "l" => ["s", "p"],
  "s" => ["r", "ss"]
}


def prompt(message)
  puts "=> #{message}"
end

def get_choice
  choice = ''
  choice_prompt = <<-MSG
    Choose one: #{VALID_CHOICES.join(', ')}.
    r: rock, p: paper, ss: scissors, l:lizard, s: spock
  MSG
  loop do
    prompt choice_prompt
    choice = gets.chomp.downcase
    if VALID_CHOICES.include?(choice)
      break choice
    else
      prompt "Not a valid choice."
    end
  end
end

def win?(p_choice, c_choice)
  WIN_OPTIONS[p_choice].any?(c_choice)

end

def display_results(player, computer)
  if win?(player, computer)
    'You won the round!'
  elsif win?(computer, player)
    'Computer won the round!'
  else
    "It's a tie!"
  end
end

def new_game?
  answer = ''
  loop do
    prompt 'Would you like to play again?'
    answer = gets.chomp.downcase
    if answer == 'y'
      break answer
    elsif answer == 'n'
      break answer
    else
      prompt 'Please enter y or n.'
    end
  end
end

def calculate_game_score

end 

def grand_winner(p_points, c_points)
  prompt 'Congratulations! You won the game!' if p_points == WIN_SCORE
  prompt 'The computer won the game!' if c_points == WIN_SCORE
end

def clear_screen
  system('clear') || system('cls')
end

prompt 'Welcome to Rock, Paper, Scissor, Lizard Spock!'

game_scores = { player: 0, computer: 0, tie: 0}
loop do
  until player_points == 5 || computer_points == 5
    computer_choice = VALID_CHOICES.sample
    player_choice = get_choice
    prompt "You chose: #{player_choice}; Computer chose: #{computer_choice}."
    display_results(player_choice, computer_choice)

    if round_winner == 'You won the round!'
       += 1
    elsif round_winner == 'Computer won the round!'
      computer_points += 1
    else
      tie += 1
    end
    puts
  end
  grand_winner(player_points, computer_points)
  play_again = new_game?
  break if play_again == 'n'
  clear_screen
end

prompt 'Thank you for playing Rock, Paper, Scissors, Lizard, Spock!'
