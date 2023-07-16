#Set the tax rates
personal_allowance=12500
basic_rate=0.2
higher_rate=0.4
#Calculate the average price of each model
A_class_avg=31095
B_class_avg=33162
C_class_avg=42537
E_class_avg=54437
AMG_C65_avg=79660
#Set the basic salary of the salesperson
basic_salary=2000
bonus_1=10000
bonus_2=15000
bonus_3=20000
bonus_4=25000
bonus_5=30000

counter=0
while [ $counter -lt 20 ]; do
    # Set the salesperson name
    salesperson="Salesperson$((counter+1))"

read -p "Enter a month: " month
month=$(echo $month | tr '[:upper:]' '[:lower:]')
case $month in
    january|february|march|april|may|june|july|august|september|october|november|december)
    # valid month input
    ;;
    *)
    echo "Invalid month entered. Please enter a valid month."
    continue
    ;;
esac

echo -n "Enter the salesperson's name: "
read salesperson
if [[ ! $salesperson =~ ^[a-zA-Z]+$ ]]; then
    echo "Invalid input. Salesperson's name should be a string, not an integer"
    exit 1
fi

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
#Calculate the total sales
total_sales=$((a_class_units * A_class_avg + b_class_units* B_class_avg + c_class_units * C_class_avg + e_class_units * E_class_avg + amg_c65_units * AMG_C65_avg))
#Calculate the bonus
if [[ $total_sales -gt 650000 ]]; then
    bonus=$bonus_5
elif [[ $total_sales -gt 500000 ]]; then
    bonus=$bonus_4
elif [[ $total_sales -gt 400000 ]]; then
    bonus=$bonus_3
elif [[ $total_sales -gt 300000 ]]; then
    bonus=$bonus_2
elif [[ $total_sales -gt 200000 ]]; then
    bonus=$bonus_1
else
    bonus=0
fi
#Calculate the total salary before tax
total_salary_before_tax=$((basic_salary + bonus))
#Calculate the total salary after tax
if [[ $total_salary_before_tax -gt $personal_allowance ]]; then
    if [[ $total_salary_before_tax -le 50000 ]]; then
        tax=$(echo "($total_salary_before_tax - $personal_allowance) * $basic_rate" | bc)
    else
        tax=$(echo "($total_salary_before_tax - $personal_allowance) * $higher_rate" | bc)
    fi
    total_salary_after_tax=$(echo "$total_salary_before_tax - $tax" | bc)
else
total_salary_after_tax=$total_salary_before_tax
fi

echo " Month: $month Salesperson: $salesperson Total sales: £$total_sales Bonus: £$bonus Total salary after tax: £$total_salary_after_tax"

echo " Month: $month Salesperson: $salesperson Total sales: £$total_sales Total salary after tax for $salesperson is £$total_salary_after_tax" >> ~/21416541/salespersons.txt

# Read the text file into an array
IFS=$'\n' read -d '' -r -a lines < ~/21416541/salespersons.txt

# Extract the salary field and store it in a new array
salaries=()
for line in "${lines[@]}"; do
    salary=$(echo $line | awk '{print $NF}' | sed 's/[^0-9]*//g')
    salaries+=($salary)
done

# Implement the bubblesort algorithm on the array of salaries
n=${#salaries[@]}
for ((i = 0; i < $n; i++)); do
    for ((j = 0; j < $n - i - 1; j++)); do
        if [[ "${salaries[j]}" < "${salaries[j + 1]}" ]]; then
            temp="${lines[j]}"
            lines[j]="${lines[j + 1]}"
            lines[j + 1]="$temp"

            temp_salary="${salaries[j]}"
            salaries[j]="${salaries[j + 1]}"
            salaries[j + 1]="$temp_salary"
        fi
    done
done

# Write the sorted array back to the text file
printf "%s\n" "${lines[@]}" > ~/21416541/salespersons.txt


counter=$((counter+1))
#Ask the user if they want to continue
read -p "Do you want to continue? (y/n): " choice
if [[ $choice == "n" ]]; then
exit 0
fi


if [[ $i -eq 20 ]]; then
echo "You have reached the maximum number of iterations"
exit 0
fi

done

