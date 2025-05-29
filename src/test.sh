#!/bin/bash

# Declare an array named 'programming_languages'
programming_languages=('Bash' 'Python' 'JavaScript' 'Ruby', 'Java')

# Guess the user's preferred language
random_number=$((RANDOM % 5))
echo "We guess your preferred language is: ${programming_languages[$random_number]}"

# Display the results
if [[ "${preferred_language}" == "${programming_languages[$random_number]}" ]]; then
    echo "Yaay, we guessed correct, it's ${preferred_language}"
else
    echo "We guessed wrong, it's ${preferred_language}"
fi