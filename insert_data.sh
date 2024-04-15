#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
# ----ADDING TEAMS----
	if [[ $WINNER != "winner" ]]
	then
	#get team name from winner
	  TEAM_FROM_WINNER=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
    echo $TEAM_FROM_WINNER
	#if not found
	  if [[ -z $TEAM_FROM_WINNER ]]
	  then
	#insert to teams
	    INSERT_WINNER_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_WINNER_TEAM == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $INSERT_WINNER_TEAM
      fi
	  fi
	fi
  if [[ $OPPONENT != "opponent" ]]
	then
	#get team name from winner
	TEAM_FROM_OPPONENT=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
	#if not found
	  if [[ -z $TEAM_FROM_OPPONENT ]]
	  then
	#insert to teams
	  INSERT_OPPONENT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_OPPONENT_TEAM == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $INSERT_OPPONENT_TEAM
      fi
	  fi
	fi

  #insert data to games
  #winner_id
  winner_id=$($PSQL "select team_id from teams where name = '$WINNER'")
  #opponent_id
  opponent_id=$($PSQL "select team_id from teams where name = '$OPPONENT'")
  #insert
  insert_sql=$($PSQL "insert into games (year,round,winner_id,opponent_id,winner_goals,opponent_goals) values ($YEAR,'$ROUND',$winner_id,$opponent_id,$WINNER_GOALS,$OPPONENT_GOALS);")
done