play_again=true

while $play_again; do
  # Initialize variables
  player_total=0
  dealer_total=0
  ace_value=11 # add a variable to represent the value of an ace

  # Deal initial cards to player and dealer
  player_card1=$((RANDOM % 10 + 1))
  player_card2=$((RANDOM % 10 + 1))
  dealer_card1=$((RANDOM % 10 + 1))
  dealer_card2=$((RANDOM % 10 + 1))

  # Calculate player total
  player_total=$((player_card1 + player_card2))
  # Check if player was dealt an ace
  if [[ $player_card1 -eq 1 || $player_card2 -eq 1 ]]; then
    player_total=$((player_total + ace_value))
    # Prompt player to use ace as 1 or 11
    while true; do
      read -p "Use ace as 1 or 11 (1/11)? " choice
      if [[ "$choice" == "1" ]]; then
        player_total=$((player_total - 10))
        ace_value=1
        break
      elif [[ "$choice" == "11" ]]; then
        break
      else
        echo "Invalid choice. Please enter 1 or 11."
      fi
    done
  fi

  # Calculate dealer total
  dealer_total=$((dealer_card1 + dealer_card2))
  # Check if dealer was dealt an ace
  if [[ $dealer_card1 -eq 1 || $dealer_card2 -eq 1 ]]; then
    dealer_total=$((dealer_total + ace_value))
    # Use ace as 1 if dealer total exceeds 21
    if [[ $dealer_total -gt 21 ]]; then
      dealer_total=$((dealer_total - 10))
      ace_value=1
    fi
  fi

  # Check for blackjacks
  if [[ $player_total -eq 21 ]]; then
    echo "Blackjack! You win!"
  elif [[ $dealer_total -eq 21 ]]; then
    echo "Dealer has a blackjack. You lose."
  else
    # Prompt player to hit or stand
    echo "Your hand: $player_card1 + $player_card2 = $player_total"
    echo "Dealer's hand: $dealer_card1 + $dealer_card2 = $dealer_total"
    read -p "Hit or stand (h/s)? " choice

    # Player's turn
    while [[ $choice == "h" ]]; do
      # Deal another card to player
      player_card=$((RANDOM % 10 + 1))
      player_total=$((player_total + player_card))
      # Check if player was dealt an ace
      if [[ $player_card -eq 1 ]]; then
        player_total=$((player_total + ace_value))
        # Prompt player to use ace as 1 or 11
        while true; do
          read -p "Use ace as 1 or 11 (1/11)? " choice
          if [[ "$choice" == "1" ]]; then
          player_total=$((player_total - 10))
ace_value=1
break
elif [[ "$choice" == "11" ]]; then
break
else
echo "Invalid choice. Please enter 1 or 11."
fi
done
fi

  # Check if player busts
  if [[ $player_total -gt 21 ]]; then
    echo "You bust! You lose."
    break
  fi

  # Prompt player to hit or stand again
  echo "Your hand: $player_card1 + $player_card2 + $player_card = $player_total"
  echo "Dealer's hand: $dealer_card1 + $dealer_card2 = $dealer_total"
  read -p "Hit or stand (h/s)? " choice
done

# Dealer's turn
if [[ $player_total -le 21 ]]; then
  while [[ $dealer_total -lt 17 ]]; do
    # Deal another card to dealer
    dealer_card=$((RANDOM % 10 + 1))
    dealer_total=$((dealer_total + dealer_card))
    # Check if dealer was dealt an ace
    if [[ $dealer_card -eq 1 ]]; then
      dealer_total=$((dealer_total + ace_value))
      # Use ace as 1 if dealer total exceeds 21
      if [[ $dealer_total -gt 21 ]]; then
        dealer_total=$((dealer_total - 10))
        ace_value=1
      fi
    fi

    # Check if dealer busts
    if [[ $dealer_total -gt 21 ]]; then
      echo "Dealer busts! You win!"
      break
    fi
  done
fi

# Compare player and dealer totals
if [[ $player_total -le 21 && $player_total -gt $dealer_total ]]; then
  echo "You win!":
elif [[ $player_total -le 21 && $player_total -lt $dealer_total ]]; then
  echo "You lose." 
elif [[ $player_total -le 21 && $player_total -eq $dealer_total ]]; then
  echo "Push."
fi

fi

read -p "Play again (y/n)? " choice
if [[ $choice == "n" ]]; then
play_again=false
fi
done
