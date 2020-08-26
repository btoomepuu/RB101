require "pry"
require 'yaml'
MESSAGES = YAML.load_file('rps_messages.yml')

VALID_CHOICES = %w(r p ss l s)
WIN_SCORE = 5

OPTIONS = {
  "r" => 'rock',
  "p" => 'paper',
  "ss" => 'scissors',
  "l" => 'lizard',
  "s" => "spock"
}

WIN_OPTIONS = {
  "r" => ["ss", "l"],
  "p" => ["s", "r"],
  "ss" => ["l", "p"],
  "l" => ["s", "p"],
  "s" => ["r", "ss"]
}
GAME_REPLAY = %w(yes y no n)

# ----------------- Methods---------------- #
def clear_screen
  system('clear') || system('cls')
end

def pause
  sleep(0.75)
end

def prompt(message)
  puts "=> #{message}"
end

def get_computer_choice
  VALID_CHOICES.sample
end

def display_welcome_rules
  prompt(MESSAGES['display_welcome'])
  puts ''
  pause
  prompt(MESSAGES['display_rules'])
  puts ''
  sleep(1)
end

def get_player_choice
  prompt(MESSAGES['choice'])
  prompt "Choose one: #{VALID_CHOICES.join(', ')}"
  choice = gets.chomp.downcase
  valid_choice?(choice)
end

def valid_choice?(player_choice)
  if VALID_CHOICES.include?(player_choice)
    player_choice
  else
    prompt(MESSAGES['valid_choice'])
    get_player_choice
  end
end

def display_choices(name_hash, p_input, c_input)
  prompt "You chose #{name_hash[p_input]} and the computer
  chose #{name_hash[c_input]}"
  pause
end

def win?(first, second)
  WIN_OPTIONS[first].any?(second)
end

def display_winner(p_choice, c_choice)
  if win?(p_choice, c_choice)
    prompt(MESSAGES['player_round'])
    pause
  elsif win?(c_choice, p_choice)
    prompt(MESSAGES['computer_round'])
  else
    prompt "It's a tie!"
  end
end

def update_score(scores, p_choice, c_choice)
  scores[:player] += 1 if win?(p_choice, c_choice)
  scores[:computer] += 1 if win?(c_choice, p_choice)
end

def display_current_score(score_hash)
  prompt "You're Score: #{score_hash[:player]}
  Computer Score: #{score_hash[:computer]} "
  pause
end

def output_grand_winner(score_hash)
  puts ''
  if score_hash[:player] == WIN_SCORE
    prompt(MESSAGES['player_win'])
  else
    prompt(MESSAGES('computer_win'))
  end
end

def new_game?
  puts ''
  prompt(MESSAGES['new_game'])
  answer = gets.chomp.downcase
  valid_new_game?(answer)
end

def valid_new_game?(input)
  if GAME_REPLAY.include?(input)
    input
  else
    prompt(MESSAGES['valid_new_game'])
    new_game?
  end
end

def reset(score_hash)
  score_hash[:player] = 0
  score_hash[:computer] = 0
end

def new_game_screen(score_hash)
  clear_screen
  prompt(MESSAGES[new_screen])
  pause
  clear_screen
  reset(score_hash)
end

# ---------------Main------------- #
display_welcome_rules

scores = { player: 0, computer: 0 }

loop do
  until scores[:player] == WIN_SCORE || scores[:computer] == WIN_SCORE
    player_choice = get_player_choice
    computer_choice = get_computer_choice
    display_choices(OPTIONS, player_choice, computer_choice)
    pause
    display_winner(player_choice, computer_choice)
    pause
    update_score(scores, player_choice, computer_choice)
    clear_screen
    display_current_score(scores)
  end

  output_grand_winner(scores)
  pause
  play_again = [new_game?]

  if play_again.include?('n') || play_again.include?('no')
    break
  else
    new_game_screen(scores)
  end
end

clear_screen

prompt(MESSAGES['display_goodbye'])
