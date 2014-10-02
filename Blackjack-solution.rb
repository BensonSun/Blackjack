def initialize_deck(deck)
  suit = ["Spade", "Club", "Heart", "Diamond"]
  value = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
  suit.each do |suit|
    value.each do |value|
      deck << [suit,value]
    end
  end
end

def calculate(someone_deck)
  values = someone_deck.map {|item| item[1] }
  total = 0
  values.each do |value|
    if value == "A"
      total += 11   
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end 
  end

  #correct A's value
  values.select {|value| value == "A" }.count.times do
    total -= 10 if total > 21
  end
  total
end

def hit_or_stay_player(someone_deck,someone_value,deck)
  if someone_value == 21
    puts "Congratulations! You hit blackjack!"
    exit
  end
  answer = " "
  while someone_value < 21  
    puts "Do you want to hit or stay? (H/S)"
    answer = gets.chomp.upcase
    
    if !["H", "S"].include?(answer)
      puts "Error: Please enter h or s!"
      next

    elsif answer == "S"
      puts "You choose to stay."
      break

    elsif answer == "H"
      someone_deck << deck.pop
      someone_value = calculate(someone_deck)
      puts "You got #{someone_deck.last[0]} #{someone_deck.last[1]} , for a total #{someone_value}"
    end

    if someone_value == 21
      puts "Congratulations! You hit blackjack!"
      exit
    elsif someone_value > 21
      puts "You busted! Dealer won!"
      exit
    end
  end 
end

def hit_or_stay_dealer(someone_deck,someone_value,deck)
  if someone_value == 21
    puts "Sorry, dealer hit blackjack! You lost!"
    exit
  end
  while someone_value < 17  
      someone_deck << deck.pop
      someone_value = calculate(someone_deck)
      puts "Dealing card to dealer: #{someone_deck.last[0]} #{someone_deck.last[1]}. Dealer's total is #{someone_value}. "
    if someone_value == 21
      puts "Sorry, dealer hit blackjack! You lost!"
      exit
    elsif someone_value > 21
      puts "Dealer busted! You won!"
      exit
    end
  end 
end

def compare(player_value,dealer_value)
  if player_value > dealer_value
    puts "Congratulations! Your won!"
  elsif player_value < dealer_value
    puts "Sorry, dealer won!"
  else
    puts "It's a tie!"
  end
end

deck = []
initialize_deck(deck)
deck.shuffle!

player_deck = []
dealer_deck = []

player_deck << deck.pop
dealer_deck << deck.pop
player_deck << deck.pop
dealer_deck << deck.pop

player_value = calculate(player_deck)
dealer_value = calculate(dealer_deck)

puts "You got #{player_deck[0][0]} #{player_deck[0][1]} and #{player_deck[1][0]} #{player_deck[1][1]}, for a total #{player_value}"
puts "Dealer got #{dealer_deck[0][0]} #{dealer_deck[0][1]} and #{dealer_deck[1][0]} #{dealer_deck[1][1]}, for a total #{dealer_value}"

hit_or_stay_player(player_deck,player_value,deck)
hit_or_stay_dealer(dealer_deck,dealer_value,deck)
compare(player_value,dealer_value)




