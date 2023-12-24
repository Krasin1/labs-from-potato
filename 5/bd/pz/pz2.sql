use airport;

# задача 1
drop view if exists workload;
create view workload as 
select Trip.id as trip, COUNT(Pass_in_trip.id) as count
from Trip inner join Pass_in_trip
on Trip.id = Pass_in_trip.trip
group by Trip.id
order by count desc;

# ответ к задаче 1
select * from workload;



# задача 2
drop view if exists flew_more_than_2;
create view flew_more_than_2 as
select passengerId1, passengerId2, count(flyings1.trip1) as count
from (select passenger as passengerId1, trip as trip1
        from Pass_in_trip
        group by passengerId1, trip1) as flyings1
inner join (select passenger as passengerId2, trip as trip2
        from Pass_in_trip
        group by passengerId2, trip2) as flyings2
on flyings1.trip1 = flyings2.trip2
where passengerId1 < passengerId2
group by passengerId1, passengerId2
having count(flyings1.trip1) > 1
order by count desc;

drop view if exists names_flew_more_than_2;
create view names_flew_more_than_2 as
select pass1.name as passengerName1, pass2.name as passengerName2, f.count
from flew_more_than_2 f
    inner join Passenger pass1
    on pass1.id = passengerId1
    inner join Passenger pass2
    on pass2.id = passengerId2;

# ответ к задаче 2
select * from names_flew_more_than_2;




# задача 3
drop view if exists passengers_from_2;
create view passengers_from_2 as
select f.passengerId1 as passengers from flew_more_than_2 f
union
select f.passengerId2 as passengers from flew_more_than_2 f;

drop view if exists ab;
create view ab as
select distinct p.passenger as p_id
from Pass_in_trip p
inner join passengers_from_2 pass on p.passenger = pass.passengers 
inner join workload on workload.trip = p.trip;

drop view if exists combine_1_2;
create view combine_1_2 as
select pass.name as passengerNameOnTrip
from Passenger pass
inner join ab on ab.p_id = pass.id;

# ответ к задаче 3
select * from combine_1_2;
