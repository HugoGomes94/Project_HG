CREATE VIEW vw_ML_Titanic as 
select t.passengerid , s.survived , CAST(t.pclass as int) as Passenger_class , t.[name] as Passenger_name ,  t.sex , t.age , t.sibsp , t.parch , t.ticket , t.fare , t.cabin , t.embarked
from dbo.test as t 
inner join dbo.submission as s ON t.passengerid = s.passengerid