if exists(select 1 from master.dbo.sysdatabases where name = 'restauracja') use master drop database restauracja
go
create database restauracja
go

use restauracja;
go

create table restauracje
(
	restauracjaID int not null primary key,
	nazwa varchar(30) not null,
	ulica varchar(50) not null,
	miasto varchar(30) not null,
	kod varchar(6) not null
);
go

create table stanowiska
(
	stanowiskoID int not null primary key,
	nazwa varchar(30) not null,
	placa_min money not null,
	placa_max money,
);
go

create table personel
(
	personelID int not null primary key,
	imie varchar(30) not null,
	nazwisko varchar(30) not null,
	stanowiskoID int not null,
	plec char(1) not null constraint personel_plec_CH check(plec='K' or plec='M'),
	dataUr smalldatetime not null,
	dataZatr smalldatetime not null,
	pensja money not null,
	restauracjaID int not null,
	constraint FKPersonelRestauracja foreign key (restauracjaID) references restauracje (restauracjaID),
	constraint FKPersonelStanowisko foreign key (stanowiskoID) references stanowiska (stanowiskoID)
);
go

create table menu
(
	menuID int not null primary key,
	restauracjaID int not null,
	constraint FKMenuRestauracja foreign key (restauracjaID) references restauracje (restauracjaID),
);
go

create table dania
(
	danieID int not null primary key,
	nazwa varchar(30) not null,
	cena money not null
);
go

create table skladniki
(
	skladnikID int not null primary key,
	nazwa varchar(30) not null,
);
go

create table menudania
(
	menudaniaID int not null primary key,
	menuID int not null,
	danieID int not null,
	constraint FKMenuDania1 foreign key (menuID) references menu (menuID),
	constraint FKMenuDania2 foreign key (danieID) references dania (danieID)
);
go

create table daniaskladniki
(
	danieID int not null,
	skladnikID int not null,
	constraint FKDaniaSkladniki1 foreign key (danieID) references dania (danieID),
	constraint FKDaniaSkladniki2 foreign key (skladnikID) references skladniki (skladnikID)
);
go

create table zamowienia
(
	zamowienieID int not null primary key,
	kelnerID int not null,
	dataZamowienia smalldatetime not null,
	constraint FKKelner foreign key (kelnerID) references personel (personelID)
);
go

create table zamowienieDania
(
	zamowienieID int not null,
	menudaniaID int not null,
	constraint FKMenuDania foreign key (menudaniaID) references menudania (menudaniaID),
	constraint FKZamowienia foreign key (zamowienieID) references zamowienia (zamowienieID),
);
go