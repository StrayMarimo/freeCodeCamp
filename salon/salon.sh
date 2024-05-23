#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

id_services=($($PSQL "SELECT service_id FROM services"))
services=($($PSQL "SELECT name FROM services"))

service_choices=""

for (( i = 0; i < ${#id_services[@]}; i++ )); do
  service_choices+="${id_services[i]}) ${services[i]}\n"
done

echo "~~~~~ MY SALON ~~~~~"
echo "Welcome to My Salon, how can I help you?"

SERVICE_ID_SELECTED=0

echo -e $service_choices
read SERVICE_ID_SELECTED

while [[ $SERVICE_ID_SELECTED -lt 1 || $SERVICE_ID_SELECTED -gt ${#id_services[@]} ]]; do
  echo -e "I could not find that service. What would you like today?\n$service_choices" 
  read SERVICE_ID_SELECTED
done

echo "What's your phone number?"
read CUSTOMER_PHONE


CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';" | tr -d '[:space:]')

if [ -z "$CUSTOMER_ID" ]; then
    echo "I don't have a record for that phone number, what's your name? "
    read CUSTOMER_NAME
    CUSTOMER_NAME=$(echo "$CUSTOMER_NAME" | tr -d '[:space:]')  # Trim whitespace
    $PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');" || { echo "Insert operation failed"; exit 1; }
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';" | tr -d '[:space:]') || { echo "Select operation failed"; exit 1; }
fi

echo "What time would you like your ${services[$SERVICE_ID_SELECTED - 1]}, $CUSTOMER_NAME? "
read SERVICE_TIME
SERVICE_TIME=$(echo "$SERVICE_TIME" | tr -d '[:space:]')  # Trim whitespace
$PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '${id_services[$SERVICE_ID_SELECTED - 1]}', '$SERVICE_TIME');" || { echo "Insert operation failed"; exit 1; }

echo "I have put you down for a ${services[$SERVICE_ID_SELECTED - 1]} at $SERVICE_TIME, $CUSTOMER_NAME."
