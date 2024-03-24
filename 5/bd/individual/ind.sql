-- Перед проведением научной конференции в оргкомитет поступают доклады участников.
-- В рамках конференции действуют несколько тематических секций.
-- На каждый поступивший доклад заполняется регистрационная карточка.
-- Перед началом конференции по имеющимся данным формируются следующие документы:
--   Перечень докладов по секциям,
--   Список докладчиков,
--   Полный алфавитный перечень докладов,
--   Делегации на конференции.

drop database if exists conference;
create database if not exists conference;
use conference;

create table if not exists speakers(
    id_speaker int primary key auto_increment,
    name varchar(100) not null,
    phone varchar(20) not null,
    organization varchar(100) not null
);

create table if not exists themes(
    id_theme int primary key auto_increment,
    theme varchar(100) not null
);

create table if not exists report(
    id_report int primary key auto_increment,
    title varchar(200) not null,
    theme int not null,
    speaker int not null,
    foreign key (theme) references themes(id_theme),
    foreign key (speaker) references speakers(id_speaker)
);

drop procedure if exists show_speakers;
delimiter //
create procedure show_speakers()
begin
    select * from speakers;
end //
delimiter ;

drop procedure if exists add_speaker;
delimiter //
create procedure add_speaker(in name varchar(100), in phone varchar(20), in organization varchar(100))
begin
    insert into speakers(name, phone, organization) values(name, phone, organization);
end // 
delimiter ;

drop procedure if exists show_reports;
delimiter //
create procedure show_reports()
begin
    select title from report order by title;
end //
delimiter ;
