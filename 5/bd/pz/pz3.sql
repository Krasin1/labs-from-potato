use airport;

# задача 1,2
drop procedure if exists min_flights;
delimiter $$
create procedure min_flights()
begin
create view company_flights as
select c.name as c_name, count(t.id) as count
from Trip t
inner join Company c on t.company = c.id
group by c.name
order by count;

select * from company_flights
where count = (select min(count) from company_flights);

drop view company_flights;
end $$
delimiter ;

# ответ к задаче 1,2
call min_flights;





# задача 3
drop view if exists name_flight_count ;
create view name_flight_count as
select p.name as name, a.count
from Passenger p 
inner join	(select passenger, count(trip) as count
			from Pass_in_trip
			group by passenger) a
on p.id = a.passenger
order by count desc, name asc;

# ответ к задаче 3
select * from name_flight_count;





# задача 4
drop view if exists company_flights_copy;
create view company_flights_copy as
select c.id as c_id, count(t.id) as count
from Trip t
inner join Company c on t.company = c.id
group by c.name
order by count;

drop view if exists min_company;
create view min_company as
select * from company_flights_copy
where count = (select min(count) from company_flights_copy);


drop view if exists trips_of_min_company;
create view trips_of_min_company as
select t.id as trip_id
from Trip t
inner join min_company c
on t.company = c.c_id;

drop view if exists min_passengers ;
create view min_passengers as 
select distinct p_t.passenger
from Pass_in_trip p_t
inner join trips_of_min_company t
on p_t.trip = t.trip_id;

drop view if exists ans_4;
create view ans_4 as
select p.name as name, a.count
from Passenger p 
inner join	(select passenger, count(trip) as count
			from Pass_in_trip
            where passenger in (select * from min_passengers)
			group by passenger) a
on p.id = a.passenger
order by count desc, name asc;


# ответ к задаче 4
select * from ans_4;

drop view company_flights_copy;


