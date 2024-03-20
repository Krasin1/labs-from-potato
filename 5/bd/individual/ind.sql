drop database if exists conference;
create database if not exists conference;
use conference;

create table if not exists speakers(
    id_speaker int primary key,
    name varchar(100) not null,
    organization varchar(100) not null,
);

create table if not exists themes(
    id_theme int primary key,
    name varchar(100) not null,
);

