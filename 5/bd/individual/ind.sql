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

-- таблица тем докладов
create table if not exists themes(
    id_theme int primary key auto_increment,
    theme varchar(100) unique not null
);

-- таблица делегаций
create table if not exists delegations(
    id_delegation int primary key auto_increment,
    name varchar(200) unique not null
);

-- табилца докладчиков
create table if not exists speakers(
    id_speaker int primary key auto_increment,
    name varchar(100) not null,
    phone varchar(20) unique not null,
    id_delegation int,
    foreign key (id_delegation) references delegations(id_delegation)
);

-- таблица докладов
create table if not exists report(
    id_report int primary key auto_increment,
    title varchar(200) not null,
    theme int not null,
    speaker int not null,
    foreign key (theme) references themes(id_theme),
    foreign key (speaker) references speakers(id_speaker)
);

insert into themes(theme) values
    ('Программирование'),
    ('Компьютерная безопасность'),
    ('Анализ данных'),
    ('Английский язык');

insert into delegations(name) values
    ('СПбГУТ'),
    ('ИТМО'),
    ('НИИ "Восход"'),
    ('СПбГУ');

insert into speakers(name, phone, id_delegation) values
    ('Зайцев А.А.', '8-800-555-35-34', 1),
    ('Иванов И.И.', '8-800-555-35-35', 1),
    ('Петров П.П.', '8-800-555-35-36', 2),
    ('Сидоров С.С.', '8-800-555-35-37', 3),
    ('Андреев В.В.', '8-800-555-35-38', 3),
    ('Кузнецов К.К.', '8-800-555-35-39', 4);

insert into report(title, theme, speaker) values
    ('Технический английский в IT', 4, 6),
    ('Нейросети в медицине', 3, 5),
    ('Безопаснось работы протокола BGP', 2, 4),
    ('Автоматизация процессов производства метизов', 1, 3),
    ('Актуальное программирование на C++', 1, 2),
    ('Алгоритмы нахождения кратчайшего пути', 1, 1);

-- добавление новой темы
drop procedure if exists add_theme;
delimiter //
create procedure add_theme(in theme varchar(100))
begin
    insert into themes(theme) values(theme);
    select concat('Тема "', theme, '" добавлена') as 'Успех';
end //
delimiter ;

-- добавление новой делегации
drop procedure if exists add_delegation;
delimiter //
create procedure add_delegation(in name varchar(200))
begin
    insert into delegations(name) values(name);
    select concat('Делегация "', name, '" добавлена') as 'Успех';
end //
delimiter ;

-- добавление нового участника
drop procedure if exists add_speaker;
delimiter //
create procedure add_speaker(in name varchar(100), in phone varchar(20), in delegation varchar(200))
begin
    declare id int default null;
    select d.id_delegation into id from delegations d where d.name = delegation;
    if id is not null then
        -- проверка на повтор
        if not exists(select s.id_speaker from speakers s where s.name = name and s.phone = phone) then
            insert into speakers(name, phone, id_delegation) values(name, phone, id);
            select concat('Участник ', name, ' добавлен ') as 'Успех';
        else
            select concat('Участник ', name, ' уже есть') as 'Ошибка';
        end if;
    else
        select concat('Делегация ', delegation, ' не найдена') as 'Ошибка';
    end if;
end //
delimiter ;

-- добавление доклада
drop procedure if exists add_report;
delimiter //
create procedure add_report(in title varchar(200), in theme varchar(100), in speaker varchar(100), in phone varchar(20))
begin
    declare id_theme int;
    declare id_speaker int;
    select t.id_theme into id_theme from themes t where t.theme = theme;
    select s.id_speaker into id_speaker from speakers s where s.name = speaker and s.phone = phone;
    if id_theme is not null and id_speaker is not null then
        -- проверка на повторное вхождение
        if not exists(select r.id_report from report r where r.title = title and r.theme = id_theme and r.speaker = id_speaker) then
            insert into report(title, theme, speaker) values(title, id_theme, id_speaker);
            select concat('Доклад "', title, '" добавлен ') as 'Успех';
        else 
            select 'Доклад уже есть' as 'Ошибка';
        end if;
    else
        select 'Тема или докладчик не найдены' as 'Ошибка';
    end if;
end //
delimiter ;

-----------------------------------------------------------

-- список тем
drop procedure if exists show_themes;
delimiter //
create procedure show_themes()
begin
    drop view if exists themes_view;
    create view themes_view as 
        select id_theme as ID, theme as Тема from themes;
    select * from themes_view;
end //
delimiter ;

-- список докладчиков 
drop procedure if exists show_speakers;
delimiter //
create procedure show_speakers()
begin
    drop view if exists speakers_view;
    create view speakers_view as
        select s.id_speaker as ID, s.name as ФИО, s.phone as Телефон, d.name as Делегация
        from speakers s
        inner join delegations d on s.id_delegation = d.id_delegation 
        order by s.name;

    select * from speakers_view;
end //
delimiter ;

-- поиск докладчика по имени
drop procedure if exists find_speaker;
delimiter //
create procedure find_speaker(in name varchar(100))
begin
    -- select * from speakers where name like concat('%', name, '%'); <<-- вот так не работает
    set @sql_query = concat("select s.id_speaker as ID, s.name as ФИО, d.name as 'Делегация', s.phone as Телефон 
    from speakers s 
    inner join delegations d on s.id_delegation = d.id_delegation
    where s.name like '%", name, "%';");
    prepare stmt from @sql_query;
    execute stmt;
    deallocate prepare stmt;
end //
delimiter ;

-- список докладов в алфавитном порядке
drop procedure if exists show_reports;
delimiter //
create procedure show_reports()
begin
    drop view if exists reports_view;
    create view reports_view as
        select r.title as Доклады, t.theme as Тема, s.name as Докладчик, s.phone as 'Телефон'
        from report r
        right join speakers s on r.speaker = s.id_speaker
        inner join themes t on r.theme = t.id_theme
        order by r.title;
    select * from reports_view;
end //
delimiter ;

-- список делегаций вместе с кол-вом участников
drop procedure if exists show_delegations;
delimiter //
create procedure show_delegations()
begin
    drop view if exists delegations_view;
    create view delegations_view as
        select d.id_delegation as ID, d.name as Делегация, count(s.id_speaker) as 'Кол-во участников'
        from speakers s
        inner join delegations d on s.id_delegation = d.id_delegation
        group by d.id_delegation
        order by d.name;
    select * from delegations_view;
end //
delimiter ;

-- список докладов по секциям
drop procedure if exists show_reports_by_theme;
delimiter //
create procedure show_reports_by_theme(in theme int)
begin
    declare sql_query varchar(1000);

    set @sql_query = concat("drop view if exists reports_view_", theme, ";");
    prepare stmt from @sql_query;
    execute stmt;
    deallocate prepare stmt;

    set @sql_query = concat("create view reports_view_", theme, " as
        select t.theme as 'Темa', r.title as 'Доклады', s.name as Докладчик, s.phone as 'Телефон Докладчика'
        from report r
        right join speakers s on r.speaker = s.id_speaker
        inner join themes t on r.theme = t.id_theme
        where r.theme = ", theme,"
        order by r.title;");
    prepare stmt from @sql_query;
    execute stmt;
    deallocate prepare stmt;

    set @sql_query = concat("select * from reports_view_", theme, ";");
    prepare stmt from @sql_query;
    execute stmt;
    deallocate prepare stmt;
end //
delimiter ;

-- список докладов по вcем секциям
drop procedure if exists show_reports_by_themes;
delimiter //
create procedure show_reports_by_themes()
begin
    declare done int default false;
    declare theme_id int;
    declare cur cursor for select distinct id_theme from themes;
    declare continue handler for not found set done = true;

    open cur;
    repeat
        fetch cur into theme_id;
        if not done then
            call show_reports_by_theme(theme_id);
        end if;
    until done end repeat;
    close cur;
end //
delimiter ;

call find_speaker('Зайцев');

call add_theme('Микроконтроллеры');
call show_themes();

call add_speaker('Зайцев А.А.', '8-800-555-35-41', 'ИТМО');
call add_report("Как работать с микроконтроллерами Altera quartus", 'Микроконтроллеры', 'Иванов И.И.', '8-800-555-35-35'); 

call add_delegation('ООО "Сбербанк"');
call add_speaker('Левченко А.А.', '8-800-555-35-40', 'ООО "Сбербанк"');
call add_report('Как работать с микроконтроллерами huaweii', 'Микроконтроллеры', 'Левченко А.А.', '8-800-555-35-40');

-- call show_reports_by_theme(1);
call show_reports_by_themes();
call show_speakers();
call show_reports();
call show_delegations();
