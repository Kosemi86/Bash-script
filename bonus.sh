#!/bin/bash

# Constants
BASIC_SALARY=2000
BONUS_200K=10000
BONUS_300K=15000
BONUS_400K=20000
BONUS_500K=25000
BONUS_650K=30000

PERSONAL_ALLOWANCE=12500
TAX_RATE_BASIC=0.2
TAX_RATE_HIGHER=0.4

# A class - £24,095 - £38,095 (average £31,095)
PRICE_A_MIN=24095
PRICE_A_MAX=38095
PRICE_A_AVG=31095

# B Class - £28,045 - £38,280 (average £33,162)
PRICE_B_MIN=28045
PRICE_B_MAX=38280
PRICE_B_AVG=33162

# C Class - £34,670 - £50,405 (average £42,537)
PRICE_C_MIN=34670
PRICE_C_MAX=50405
PRICE_C_AVG=42537

# E Class - £39,680 - £69,015 (average £54,437)
PRICE_E_MIN=39680
PRICE_E_MAX=69015
PRICE_E_AVG=54437

# AMG C65 - £78,103 - £81,217 (average £79,660)
PRICE_AMG_MIN=78103
PRICE_AMG_MAX=81217
PRICE_AMG_AVG=79660

# Function to calculate the bonus based on total sales
calculate_bonus() {
  if [ "$1" -ge 200000 ] && [ "$1" -lt 300000 ]; then
    echo $BONUS_200K
  elif [ "$1" -ge 300000 ] && [ "$1" -lt 400000 ]; then
    echo $BONUS_300K
  elif [ "$1" -ge 400000 ] && [ "$1" -lt 500000 ]; then
    echo $BONUS_400K
  elif [ "$1" -ge 500000 ] && [ "$1" -lt 650000 ]; then
    echo $BONUS_500K
  elif [ "$1" -ge 650000 ]; then
    echo $BONUS_650K
  else
    echo 0
  fi
}

# Function to calculate the tax based on salary
calculate_tax() {
  if [ "$1" -le "$PERSONAL_ALLOWANCE" ]; then
    echo 0
  elif [ "$1" -gt "$PERSONAL_ALLOWANCE" ] && [ "$1" -le 50000 ]; then
    tax=$((($1 - $PERSONAL_ALLOWANCE) * $TAX_RATE_BASIC))
    echo $tax
  elif [ "$1" -gt 50000 ]; then
    tax=$(((50000 - $PERSONAL_ALLOWANCE) * $TAX_RATE_BASIC))
    tax=$((tax + (($1- 50000) * $TAX_RATE_HIGHER)))
    echo $tax
  else
    echo 0
  fi
}

# Function to calculate the total salary of a salesperson
calculate_total_salary() {
  salary=$1
  bonus=$2
  tax=$3

  total_salary=$((salary + bonus - tax))
  echo $total_salary
}

# Prompt the user to enter the month, the name of the salesperson, and the number of units sold for each model
echo -n "Enter the month: "
read month
echo -n "Enter the salesperson's name: "
read salesperson
echo -n "Enter the number of A Class units sold: "
read a_class_units
echo -n "Enter the number of B Class units sold: "
read b_class_units
echo -n "Enter the number of C Class units sold: "
read c_class_units
echo -n "Enter the number of E Class units sold: "
read e_class_units
echo -n "Enter the number of AMG C65 units sold: "
read amg_c65_units

# Calculate the total sales
total_sales=$((a_class_units * A_class_avg + b_class_units* B_class_avg + c_class_units * C_class_avg + e_class_units * E_class_avg + amg_c65_units * AMG_C65_avg))




# Calculate total sales
total_sales=0

for model in $models; do
  if [ "$model" == "A" ]; then
    total_sales=$((total_sales + PRICE_A_AVG))
  elif [ "$model" == "B" ]; then
    total_sales=$((total_sales + PRICE_B_AVG))
  elif [ "$model" == "C" ]; then
    total_sales=$((total_sales + PRICE_C_AVG))
  elif [ "$model" == "E" ]; then
    total_sales=$((total_sales + PRICE_E_AVG))
  elif [ "$model" == "AMG" ]; then
    total_sales=$((total_sales + PRICE_AMG_AVG))
  fi
done

# Calculate bonus
bonus=$(calculate_bonus $total_sales)

# Calculate tax
tax=$(calculate_tax $(($BASIC_SALARY + $bonus)))

# Calculate total salary
total_salary=$(calculate_total_salary $BASIC_SALARY $bonus $tax)

# Display results
echo "Month: $month"
echo "Name: $name"
echo "Total sales: £$total_sales"
echo "Bonus: £$bonus"
echo "Tax: £$tax"
echo "Total salary: £$total_salary"


	

