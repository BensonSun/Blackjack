# 1. Ask the player's name
# 2. Issue two cards to two players
# 3. Calculate the value of the cards
# 4. ask if player and computer want to hit or stay
# 5. When computer & player choose to stay, calculate the value of the cards

require 'pry'
player_name = " "
bet_value = " "

begin  
  puts "What's your name?"
  player_name = gets.chomp
end until !(player_name.empty?)

begin  
  puts "#{player_name}, how much do you want to bet?"
  bet_value = gets.chomp.to_i
end until bet_value != 0


puts "#{player_name}, you've bet $#{bet_value}!"
deck = []
player_deck = []
computer_deck = []

def initialize_deck(deck)
  suit = ["Spade", "Club", "Heart", "Diamond"]
  value = [1,2,3,4,5,6,7,8,9,10,11,12,13]
  suit.product(value)
end


def player_card_assignment(deck,player_deck)
  player_card = deck.sample
  deck.delete(player_card)
  player_deck << player_card
end


def computer_card_assignment(deck,computer_deck)
  computer_card = deck.sample
  deck.delete(computer_card)
  computer_deck << computer_card
end

player_value = 0
computer_value = 0


def calculate_player_value_first(player_name,player_deck)
  player_value = 0
  i = 0
  2.times do 
      if player_deck[i][1] > 10
        n = 10
      elsif player_deck[i][1] == 1
        puts "#{player_name}, what do you want your ACE to be? (1 or 11)"
        n = gets.chomp.to_i
      else
        n = player_deck [i][1]
      end
    player_value += n
    i +=1
  end
  return player_value
end


def calculate_player_value_afterwards(player_value,player_deck)
  num = player_deck.count
    if player_deck[num-1][1] > 10
      n = 10
    elsif player_deck[num-1][1] == 1
      puts "What do you want your ACE to be? (1 or 11)"
      n = gets.chomp.to_i
    else
      n = player_deck [num-1][1]
    end
  player_value = player_value + n
  return player_value
end

def calculate_computer_value_first(computer_deck)
  computer_value = 0
  i = 0
  2.times do 
      if computer_deck[i][1] > 10
        n = 10
      elsif computer_deck[i][1] == 1 
        if computer_deck.reject{|item| item[1] == 1}[0][1] + 11 >21 #若A當11點會爆牌就選1，不會就選11
          n = 1
        else
          n = 11
        end
      else
        n = computer_deck [i][1]
      end
    computer_value = computer_value + n
    i +=1
  end
  return computer_value
end


def calculate_computer_value_afterwards(computer_value,computer_deck)
  num = computer_deck.count
    if computer_deck[num-1][1] > 10
        n = 10
      elsif computer_deck[num-1][1] == 1 
        if computer_deck.reject{|item| item[1] == 1}[0][1] + 11 >21 #若A當11點會爆牌就選1，不會就選11
          n = 1
        else
          n = 11
        end
      else
        n = computer_deck [num-1][1]
      end
    computer_value = computer_value + n
  return computer_value
end

def hit_or_stay_player(deck,player_name,player_deck,player_value)
  begin 
  puts "Do you want to hit or stay? (h/s)"
  answer = gets.chomp.to_s.upcase
    if answer == "H"
      player_card_assignment(deck, player_deck)
      puts "#{player_name}, you got #{player_deck[player_deck.count-1][0]} #{player_deck[player_deck.count-1][1]}"
      player_value = calculate_player_value_afterwards(player_value,player_deck)
      puts "Your total value is #{player_value} now"
    end
  end until player_value > 21 || answer == "S"
  return player_value
end

def hit_or_stay_computer(deck,computer_deck,computer_value)
  begin 
    if computer_value < 17 #17點以下繼續要牌 
      computer_card_assignment(deck,computer_deck)
      puts "Computer got #{computer_deck[computer_deck.count-1][0]} #{computer_deck[computer_deck.count-1][1]}"
      computer_value = calculate_computer_value_afterwards(computer_value,computer_deck)
      puts "Computer's total value is #{computer_value} now"
    end
  end until computer_value >= 17
  return computer_value
end

def value_comparison(player_value,computer_value,bet_value,player_deck,computer_deck)
  if player_deck.flatten & [6,7,8] == [6,7,8] && player_value == 21
    puts "Player won!"
    puts "678 streak! You've won #{5*bet_value}"
  elsif computer_deck.flatten & [6,7,8] == [6,7,8] && player_value == 21
    puts "Computer won!"
    puts "678 streak! You've lost #{5*bet_value}"
  elsif player_value == 21 && player_value != computer_value 
    puts "Player won!"
    puts "You've won #{2*bet_value}"
  elsif computer_value == 21 && play_value != computer_value 
    puts "Computer won!"
    puts "You've lost #{2*bet_value}"
  elsif player_value > 21 
    puts "Player busted! Computer won!"
    puts "You've lost #{bet_value}"
  elsif computer_value > 21 
    puts "Computer busted! Player won!"
    puts "You've won #{bet_value}"
  elsif player_value > computer_value
    puts "Player won!"
    puts "You've won #{bet_value}"
  elsif player_value < computer_value
    puts "Computer won!"
    puts "You've lost #{bet_value}"
  elsif player_value == computer_value
    puts "It's a tie!"
  end
end


deck = initialize_deck(deck)

player_card_assignment(deck,player_deck)
player_card_assignment(deck,player_deck)
puts "#{player_name}, you got #{player_deck[player_deck.count-2][0]} #{player_deck[player_deck.count-2][1]}"
puts "#{player_name}, you got #{player_deck[player_deck.count-1][0]} #{player_deck[player_deck.count-1][1]}"
player_value = calculate_player_value_first(player_name,player_deck)
puts "Your total value is #{player_value} now"

computer_card_assignment(deck,computer_deck)
puts "Dealt a card to computer..."
computer_card_assignment(deck,computer_deck)
puts "Computer got #{computer_deck[computer_deck.count-1][0]} #{computer_deck[computer_deck.count-1][1]}"
computer_value = calculate_computer_value_first(computer_deck)

player_value = hit_or_stay_player(deck,player_name,player_deck,player_value)
computer_value = hit_or_stay_computer(deck,computer_deck,computer_value)




p player_value
p computer_value
value_comparison(player_value,computer_value,bet_value,player_deck,computer_deck)
