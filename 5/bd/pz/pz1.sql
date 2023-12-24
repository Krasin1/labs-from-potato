use airport

# задача 1
create view from_paris as
select town_to, time_format(timediff(time_in, time_out), '%H:%i:%s') as flight_time
from Trip
where town_from = "Paris"
order by flight_time;

# ответ к задаче 1
select * from from_paris;
