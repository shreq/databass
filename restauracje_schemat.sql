if exists(select 1 from master.dbo.sysdatabases where name = 'restauracja') use master drop database restauracja
go
create database restauracja
go

use restauracja;
go

create table restauracje (
	restauracjaNr int not null primary key,
	nazwa varchar(25) not null,
	ulica varchar(25) not null,
	miasto varchar(25) not null,
	kod varchar(6) not null
);
go

create table stanowiska (
	stanowiskoNr int not null primary key,
	nazwa varchar(25) not null,
	placa_min money not null,
	placa_max money,
);
go

create table personel (
	personelNr int not null primary key,
	imie varchar(25) not null,
	nazwisko varchar(25) not null,
	stanowiskoNr int not null,
	plec char(1) not null constraint czytelnicy_plec_CH check(plec='K' or plec='M'),
	dataUr smalldatetime not null,
	pensja money not null,
	restauracjaNr int not null,
	constraint FKPersonelRestauracja foreign key (restauracjaNr) references restauracje (restauracjaNr),
	constraint FKPersonelStanowisko foreign key (stanowiskoNr) references stanowiska (stanowiskoNr)
);
go

create table menu (
	menuNr int not null primary key,
	restauracjaNr int not null,
	constraint FKMenuRestauracja foreign key (restauracjaNr) references restauracje (restauracjaNr),
);
go

create table dania (
	danieNr int not null primary key,
	nazwa varchar(25) not null,
	cena money not null
);
go

create table skladniki (
	skladnikNr int not null primary key,
	nazwa varchar(25) not null,
);
go

create table menudania (
	menuNr int not null,
	danieNr int not null,
	constraint FKMenuDania2 foreign key (menuNr) references menu (menuNr),
	constraint FKMenuDania3 foreign key (danieNr) references dania (danieNr)
);
go

create table daniaskladniki (
	danieNr int not null,
	skladnikNr int not null,
	constraint FKDaniaSkladniki1 foreign key (danieNr) references dania (danieNr),
	constraint FKDaniaSkladniki2 foreign key (skladnikNr) references skladniki (skladnikNr)
);
go
