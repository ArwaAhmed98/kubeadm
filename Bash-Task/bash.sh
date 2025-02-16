#!/bin/bash

# Define the input file
file="sample.txt"

# Read the file line by line
while IFS=',' read -r name email id; do
    # Trim whitespace from ID
    id=$(echo "$id" | tr -d '[:space:]')

    # Check if id is a valid number
   email_regex="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

    # Check if both ID is a valid number OR Email is valid
    if [[ "$id" =~ ^[0-9]+$ ]] || [[ "$email" =~ $email_regex ]]; then
        if (( id % 2 == 0 )); then
            echo "id ($id) is even"
            echo $name 
            echo $email
        else
            echo "id ($id) is odd"
            echo $name
            echo $email
        fi
    else
        # echo "id ($id) is not a valid number"
        continue #silent
    fi

    echo "----------------------"
done < "$file"
