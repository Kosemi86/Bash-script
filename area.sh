#!/bin/bash


# Loop until the user quits
while true; do
  # Prompt the user to enter unit of measurement
  read -p "Enter 1 for centimeters or 2 for inches: " unit
if [ "$unit" != "1" ] && [ "$unit" != "2" ]; then
    echo "Error: Invalid input. Please enter 1 or 2."
    continue
fi

  # Use a regular expression to check if the input is a valid number in the correct format
  if ! [[ $unit =~ ^[0-9]+$ ]]; then
    # If the input is not a valid number, display an error message and prompt the user to try again
    echo "Error: Invalid input. Please enter a valid number in the correct format."
    continue
  fi

  # Prompt the user to enter width of the rectangle
  read -p "Enter width of the rectangle: " width

  # Use a regular expression to check if the input is a valid number in the correct format
  if ! [[ $width =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    # If the input is not a valid number, display an error message and prompt the user to try again
    echo "Error: Invalid input. Please enter a valid number in the correct format."
    continue
  fi


  # Prompt the user to enter height of the rectangle
  read -p "Enter height of the rectangle: " height

  # Use a regular expression to check if the input is a valid number in the correct format
  if ! [[ $height =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    # If the input is not a valid number, display an error message and prompt the user to try again
    echo "Error: Invalid input. Please enter a valid number in the correct format."
    continue
  fi

  # Convert width and height to centimeters if necessary
  if [ "$unit" = "2" ]; then
    width_cm=$(echo "$width * 2.54" | bc)
    height_cm=$(echo "$height * 2.54" | bc)
  else
    width_cm=$width
    height_cm=$height
  fi

  # Calculate the area of the rectangle in centimeters
  area_cm=$(echo "$width_cm * $height_cm" | bc)

  # Calculate the area of the rectangle in square meters
  area_m=$(echo "$area_cm * 0.0001" | bc)

  # Calculate the area of the rectangle in square inches
 area_in=$(printf "%.2f" "$(echo "$area_cm * 0.155" | bc)")


  # Prompt the user to enter the desired unit of area
  read -p "Enter '1' for square meters or '2' for square inches: " unit
if [ "$unit" != "1" ] && [ "$unit" != "2" ]; then
    echo "Error: Invalid input. Please enter 1 or 2."
    continue
fi

  # Use a regular expression to check if the input is a valid number in the correct format
  if ! [[ $unit =~ ^[0-9]+$ ]]; then
    # If the input is not a valid number, display an error message and prompt the user to try again
    echo "Error: Invalid input. Please enter a valid number in the correct format."
    continue
  fi

  # Output the area of the rectangle in the desired unit
  if [ "$unit" = "1" ]; then
    echo "Ther area of the rectangle is $area_m sqaure meters"
  else
   
    echo "The are of the rectangle is $area_in sqaure inches."

  fi



  # Prompt the user to input different data or quit the program
  echo -n "Enter any key to start again or 'q' to quit: "
  read user_input
  if [ "$user_input" = "q" ]; then
    break
  fi
done

