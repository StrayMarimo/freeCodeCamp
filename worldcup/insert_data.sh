#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# Delete existing records from tables
echo "Deleting existing records..."
$PSQL "DELETE FROM games;"
$PSQL "DELETE FROM teams;"

# Insert data from games.csv (skipping the header line)
echo "Inserting data from games.csv..."
tail -n +2 games.csv | while IFS=',' read -r year round winner opponent winner_goals opponent_goals; do
    # Insert winner team if not already present
    $PSQL "INSERT INTO teams (name) VALUES ('$winner') ON CONFLICT (name) DO NOTHING;"

    # Insert opponent team if not already present
    $PSQL "INSERT INTO teams (name) VALUES ('$opponent') ON CONFLICT (name) DO NOTHING;"

    # Insert game
    $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals)
           SELECT $year, '$round', (SELECT team_id FROM teams WHERE name = '$winner'),
                                   (SELECT team_id FROM teams WHERE name = '$opponent'),
                                   $winner_goals, $opponent_goals
           WHERE EXISTS (SELECT 1 FROM teams WHERE name = '$winner' AND EXISTS (SELECT 1 FROM teams WHERE name = '$opponent'));"
done

echo "Data insertion completed."