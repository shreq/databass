
insert into restauracja.dbo.restauracje values(1,'Nazwa1','Piotrkowska 100','Lodz','90-022');
insert into restauracja.dbo.restauracje values(2,'Nazwa2','Zachodnia 36','Lodz','90-053');
insert into restauracja.dbo.restauracje values(3,'Nazwa3','Pilsudskiego 137','Warszawa','91-212');
--insert into restauracja.dbo.restauracje values(4,'Nazwa4','Wigury 40','Lodz','90-121');
--insert into restauracja.dbo.restauracje values(5,'Nazwa5','Radwanska 32','Lodz','90-049');
select * from restauracja.dbo.restauracje;
go

insert into restauracja.dbo.stanowiska values(1,'kierownik',4000,6000);
insert into restauracja.dbo.stanowiska values(2,'szef kuchni',3000,4000);
insert into restauracja.dbo.stanowiska values(3,'kucharz',2000,3000);
insert into restauracja.dbo.stanowiska values(4,'kelner',1500,2500);
select * from restauracja.dbo.stanowiska;
go

insert into restauracja.dbo.personel values (1,'Katarzyna','Morawska',1,'K','1971-05-06',1700,1);
insert into restauracja.dbo.personel values (2,'Maria','Hojna',2,'K','1970-2-19',900,1);
insert into restauracja.dbo.personel values (3,'Sabina','Bober',3,'K','1940-6-3',2400,1);
insert into restauracja.dbo.personel values (4,'Daniel','Frankowski',3,'M','1958-3-24',1800,1);
insert into restauracja.dbo.personel values (5,'Ma³gorzata','Kowalska',4,'K','1972-3-15',1000,1);
insert into restauracja.dbo.personel values (6,'Anna','Bia³y',4,'K','1960-11-10',1200,1);
insert into restauracja.dbo.personel values (7,'Katarzyna','Michalska',4,'K','1960-11-17',2500,1);
insert into restauracja.dbo.personel values (8,'Dawid','Piotrowski',1,'M','1975-3-22',1100,2);
insert into restauracja.dbo.personel values (9,'Ma³gorzata','Plichta',2,'K','1971-10-3',1200,2);
insert into restauracja.dbo.personel values (10,'Karolina','Mucha',3,'K','1953-3-3',2200,2);
insert into restauracja.dbo.personel values (11,'Piotr','Cybulski',3,'M','1974-12-6',1300,2);
insert into restauracja.dbo.personel values (12,'Pawe³','Nowak',4,'M','1962-2-2',1500,2);
insert into restauracja.dbo.personel values (13,'Pawe³','Kowalski',4,'M','1969-5-5',1000,2);
insert into restauracja.dbo.personel values (14,'Monika','Munk',1,'K','1977-7-26',1100,3);
insert into restauracja.dbo.personel values (15,'Jan','Wiœniewski',2,'M','1945-10-1',3000,3);
insert into restauracja.dbo.personel values (16,'Julia','Lisicka',3,'K','1965-7-13',900,3);
insert into restauracja.dbo.personel values (17,'Micha³','Brzêczyk',4,'M','1959-3-15',1000,3);
select * from restauracja.dbo.restauracje;
go
