#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please provide an element as an argument."
    exit 0
fi

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
find_by_symbol() {
    symbol="$1"
    atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$symbol';")
    if [ -n "$atomic_number" ]; then
      get_by_atomic_number "$atomic_number"
    else
      echo "I could not find that element in the database."
    fi
}

find_by_name() {
    name="$1"
    atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$name';")
    if [ -n "$atomic_number" ]; then
      get_by_atomic_number "$atomic_number"
    else
      echo "I could not find that element in the database."
    fi
}

get_by_atomic_number() {
    atomic_number="$1"
    name=$($PSQL "SELECT name FROM elements WHERE atomic_number = $atomic_number;")
    if [ -n "$name" ]; then
      symbol=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $atomic_number;")
      type=$($PSQL "SELECT t.type FROM properties p JOIN types t ON p.type_id = t.type_id WHERE p.atomic_number = $atomic_number;")
      mass=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $atomic_number;")
      melting_point=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $atomic_number;")
      boiling_point=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $atomic_number;")
      echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
    else
      echo "I could not find that element in the database."
    fi 
}

search_term="$1"
if [[ "$search_term" =~ ^[0-9]+$ ]]; then
    get_by_atomic_number "$search_term"
elif [ ${#search_term} -le 2 ]; then
    find_by_symbol "$search_term"
else
    find_by_name "$search_term"
fi