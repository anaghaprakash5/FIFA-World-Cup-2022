-- CREATE DATABASE & SELECT DATA.


CREATE DATABASE Fifa

SELECT * FROM Goals
SELECT * FROM Group1
SELECT * FROM Matches
SELECT * FROM Stadiums
SELECT * FROM Teams


-- FINDING THE TOTAL GOALS SCORED IN THE TOURNAMENT.


SELECT COUNT(G.Goal_ID) AS Total_Goals_Scored 
FROM Goals G


-- FINDING THE NUMBER OF GOALS SCORED IN EACH ROUND.


SELECT G.Round, COUNT(G.Goal_ID) AS Goals_Per_Round 
FROM Goals G WHERE G.Round IN (
  'Group Stage', 'Round of 16', 'Quarter Final', 
  'Semi Final', '3rd Palce Playoff', 'Final') 
GROUP BY G.Round 
ORDER BY Goals_Per_Round DESC


-- FINDING THE NUMBER OF GAMES WON BY EACH TEAM.


SELECT G.Team_Name, T.Wins, G.Position 
FROM Group1 G 
JOIN Teams T ON G.Team_ID = T.Team_ID 
WHERE G.Position = 1 
GROUP BY G.Team_Name, T.Wins, G.Position 
ORDER BY T.Wins DESC


-- FINDING THE GOALS SCORED & CONCEDED BY THE TEAMS THAT DIDN'T QUALIFY THE GROUP STAGE.


SELECT Team_Name, Goals_Scored, Goals_Conceded, Highest_Finish 
FROM Teams 
WHERE Highest_Finish = 'Group Stage' 
GROUP BY Team_Name, Goals_Scored, Goals_Conceded, Highest_Finish 
ORDER BY Team_Name


-- FINDING THE TEAM WITH HIGHEST NUMBER OF BOOKINGS (RED CARD + YELLOW CARD).


SELECT Team_Name, 
MAX(Yellow_Cards + Red_Cards) AS Number_Of_Bookings 
FROM Teams 
GROUP BY Team_Name 
ORDER BY Number_Of_bookings DESC 
LIMIT 1


-- FINDING THE TEAMS WHICH DIDN'T SCORE IN THE GROUP STAGE.


SELECT T.Team_Name, G.Points_Gained 
FROM Group1 G 
JOIN Teams T ON G.Group_ID = T.Group_ID 
WHERE G.Points_Gained = 0 
GROUP BY T.Team_Name, G.Points_Gained


-- FINDING THE TOP GOAL SCORER.


SELECT Goal_Scorer, COUNT(Goal_ID) AS Number_Of_Goals 
FROM Goals 
GROUP BY Goal_Scorer 
ORDER BY Number_Of_Goals DESC 
LIMIT 1


-- FINDING THE LATEST MINUTE THE TOP SCORER SCORED.


SELECT Goal_Minute 
FROM Goals 
WHERE Goal_Scorer = 'Kylian Mbappe' 
GROUP BY Goal_Scorer, Goal_Minute 
ORDER BY Goal_Minute 
LIMIT 1


-- NOW WE FIND WHEN WAS THE LAST GAME AT AL JANOUB STADIUM PLAYED.


SELECT Date FROM Matches 
WHERE Stadium_Name = 'Al Janoub Stadium' 
GROUP BY Stadium_Name, Date 
ORDER BY Date 
LIMIT 1


-- FINDING THE HIGHEST ROUND THAT ALL THE GROUP WINNERS REACHED.


SELECT G.Team_Name, T.Highest_Finish 
FROM Group1 G 
JOIN Teams T ON G.Group_ID = T.Group_ID 
WHERE G.Position = 1 
GROUP BY G.Team_Name, T.Highest_Finish, G.Position 
ORDER BY G.Team_Name


-- FINDING THE TEAMS AGAINST WHICH LIONEL MESSI & KYLIAN MBAPPE SCORED.


SELECT Goal_Scorer, Scored_Against 
FROM Goals G 
WHERE Goal_Scorer = 'Lionel Messi' OR Goal_Scorer = 'Kylian Mbappe' 
GROUP BY Goal_Scorer, Scored_Against


-- IDENTIFYING THE TEAMS THAT HAD A NEGATIVE GOAL DIFFERENCE.


SELECT Team_Name, (Goals_Scored - Goals_Conceded) AS Goal_Difference 
FROM Teams 
GROUP BY Team_Name, Goals_Scored, Goals_Conceded 
HAVING Goals_Scored - Goals_Conceded < 0 
ORDER BY Goal_Difference


-- FINDING THE PLAYER WHO SCORED THE OPENING GOAL & IN WHICH MINUTE.


SELECT G.Goal_Scorer, G.Goal_Minute 
FROM Goals G 
WHERE G.Goal_ID = 1 
GROUP BY G.Goal_Scorer, G.Goal_Minute


-- IDENTIFYING THE TEAMS PLAYED AT STADIUM 974.


SELECT Stadium_Name, Home_Team, Away_Team 
FROM Stadiums 
WHERE Stadium_Name = 'Stadium 974'
