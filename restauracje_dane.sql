use master
go

-- Restauracje
-- restauracjaID, nazwa, ulica, miasto, kod pocztowy
insert into restauracja..restauracje values(1, 'U żbika',    'Piotrkowska 100',  'Łódź',     '90-022');
insert into restauracja..restauracje values(2, 'Falafel',    'Łódzka 71',        'Zgierz',   '95-100');
insert into restauracja..restauracje values(3, 'Pitstop',    'Piłsudskiego 137', 'Warszawa', '91-212');
insert into restauracja..restauracje values(4, 'Sushi bar',  'Wigury 40',        'Łódź',     '90-121');
insert into restauracja..restauracje values(5, 'Mleczarnia', 'Radwańska 32',     'Łódź',     '90-049');
--select * from restauracja..restauracje;
go

-- Stanowiska
-- stanowiskoID, nazwa, placa_min, placa_max
insert into restauracja..stanowiska values(1, 'kierownik',   4000, 6000);
insert into restauracja..stanowiska values(2, 'szef kuchni', 3000, 4000);
insert into restauracja..stanowiska values(3, 'kucharz',     2000, 3000);
insert into restauracja..stanowiska values(4, 'kelner',      1000, 2500);
--select * from restauracja..stanowiska;
go

-- Personel, każdy ma przypisane Stanowisko oraz Restauracje
-- personelID, imie, nazwisko, stanowiskoID, plec, dataUr, pensja, restauracjaID
insert into restauracja..personel values ( 1, 'Jan',        'Żbik',       1, 'M', '1951-05-06', '1995-04-30', 2800, 1);
insert into restauracja..personel values ( 2, 'Maria',      'Hojna',      2, 'K', '1970-02-19', '1995-04-30', 2200, 1);
insert into restauracja..personel values ( 3, 'Sabina',     'Bober',      3, 'K', '1940-06-03', '1995-05-15', 1800, 1);
insert into restauracja..personel values ( 4, 'Daniel',     'Frankowski', 3, 'M', '1958-03-24', '2000-01-16', 1750, 1);
insert into restauracja..personel values ( 5, 'Krzysztof',  'Frankowski', 3, 'M', '1958-03-24', '2000-02-01', 1750, 1);
insert into restauracja..personel values ( 6, 'Małgorzata', 'Kowalska',   4, 'K', '1972-03-15', '2001-03-04', 1300, 1);
insert into restauracja..personel values ( 7, 'Anna',       'Biały',      4, 'K', '1960-11-10', '1995-05-31', 1200, 1);
insert into restauracja..personel values ( 8, 'Katarzyna',  'Michalska',  4, 'K', '1960-11-17', '1995-04-30', 1500, 1);

insert into restauracja..personel values ( 9, 'Filip',      'Piotrowski', 1, 'M', '1975-03-22', '1999-03-25', 2000, 2);
insert into restauracja..personel values (10, 'Karol',      'Mucha',      2, 'M', '1953-03-03', '1999-12-14', 2000, 2);
insert into restauracja..personel values (11, 'Piotr',      'Cybulski',   3, 'M', '1974-12-06', '2004-09-01', 1500, 2);
insert into restauracja..personel values (12, 'Paweł',      'Nowak',      4, 'M', '1962-02-02', '1999-12-14', 1200, 2);
insert into restauracja..personel values (13, 'Paweł',      'Kowalski',   4, 'M', '1969-05-05', '2000-06-21', 1000, 2);

insert into restauracja..personel values (14, 'Monika',     'Munk',       1, 'K', '1977-07-26', '2008-04-02', 2200, 3);
insert into restauracja..personel values (15, 'Jan',        'Wiśniewski', 2, 'M', '1945-10-01', '2008-04-02', 2200, 3);
insert into restauracja..personel values (16, 'Julia',      'Lisicka',    3, 'K', '1965-07-13', '2010-03-29', 1700, 3);
insert into restauracja..personel values (17, 'Małgorzata', 'Plichta',    3, 'K', '1971-10-03', '2011-11-30', 1800, 3);
insert into restauracja..personel values (18, 'Michał',     'Brzęczyk',   4, 'M', '1959-03-15', '2008-04-02', 1300, 3);
insert into restauracja..personel values (19, 'Fabian',     'Małysz',     4, 'M', '1990-02-25', '2015-07-01', 1200, 3);

insert into restauracja..personel values (20, 'Franek',     'Kimono',     1, 'M', '1946-06-08', '1983-08-13', 3000, 4);
insert into restauracja..personel values (21, 'Hubert',     'Pinus',      2, 'M', '1997-09-11', '2011-06-28', 2600, 4);
insert into restauracja..personel values (22, 'Maja',       'Głód',       3, 'K', '1985-02-25', '1999-01-18', 2400, 4);
insert into restauracja..personel values (23, 'Michał',     'Szczot',     4, 'M', '1992-08-15', '2008-02-02', 1200, 4);
insert into restauracja..personel values (24, 'Damian',     'Wróbel',     4, 'M', '1990-02-28', '2008-03-03', 1200, 4);

insert into restauracja..personel values (25, 'Mirosław',   'Schab',      1, 'M', '1950-08-18', '1980-09-01', 3000, 5);
insert into restauracja..personel values (26, 'Halina',     'Schab',      2, 'K', '1960-02-28', '1980-09-01', 2000, 5);
insert into restauracja..personel values (27, 'Piotr',      'Schab',      3, 'M', '1985-04-16', '2002-06-30', 1000, 5);
insert into restauracja..personel values (28, 'Mariola',    'Schab',      4, 'K', '1990-05-21', '2008-06-30', 1000, 5);
--select * from restauracja.dbo.personel;
go

-- Menu, każde ma przypisaną Restauracje
-- menuID, restauracjaID
insert into restauracja..menu values (1, 1);
insert into restauracja..menu values (2, 2);
insert into restauracja..menu values (3, 3);
insert into restauracja..menu values (4, 4);
insert into restauracja..menu values (5, 5);
insert into restauracja..menu values (6, 3);
--select * from restauracja..menu
go

-- Dania
-- danieID, nazwa, cena
insert into restauracja..dania values ( 1, 'woda', 1);
insert into restauracja..dania values ( 2, 'cola', 2);
insert into restauracja..dania values ( 3, 'piwo', 7);
insert into restauracja..dania values ( 4, 'sake', 7);
insert into restauracja..dania values ( 5, 'kawa', 5);
insert into restauracja..dania values ( 6, 'kurczak z rożna',     15);
insert into restauracja..dania values ( 7, 'tosty z serem',        8);
insert into restauracja..dania values ( 8, 'dorsz z frytkami',    20);
insert into restauracja..dania values ( 9, 'pieczone żeberka',    35);
insert into restauracja..dania values (10, 'szaszłyk z frytkami', 20);
insert into restauracja..dania values (11, 'stek',      25);
insert into restauracja..dania values (12, 'hamburger', 10);
insert into restauracja..dania values (13, 'jajecznica', 5);
insert into restauracja..dania values (14, 'falafel',   10);
insert into restauracja..dania values (15, 'naleśniki', 10);
insert into restauracja..dania values (16, 'guacamole', 15);
insert into restauracja..dania values (17, 'hotdog',     6);
insert into restauracja..dania values (18, 'pizza',     20);
insert into restauracja..dania values (19, 'surówka',    5);
insert into restauracja..dania values (20, 'sałatka',    7);
insert into restauracja..dania values (21, 'kanapka',    6);
insert into restauracja..dania values (22, 'sushi',     15);
insert into restauracja..dania values (23, 'ramen',      8);
insert into restauracja..dania values (24, 'tempura',   25);
insert into restauracja..dania values (25, 'pierogi',   10);
insert into restauracja..dania values (26, 'rosół',      8);
insert into restauracja..dania values (27, 'flaki',     12);
insert into restauracja..dania values (28, 'schabowy',   8);
--select * from restauracja..dania
go

-- MenuDania, wiąże dane Danie z danym Menu
-- menuID, danieID
insert into restauracja..menudania values (1,  1);
insert into restauracja..menudania values (1,  2);
insert into restauracja..menudania values (1,  3);
insert into restauracja..menudania values (1,  5);
insert into restauracja..menudania values (1,  6);
insert into restauracja..menudania values (1,  7);
insert into restauracja..menudania values (1,  8);
insert into restauracja..menudania values (1,  9);
insert into restauracja..menudania values (1, 10);
insert into restauracja..menudania values (1, 11);
insert into restauracja..menudania values (1, 12);
insert into restauracja..menudania values (1, 27);
insert into restauracja..menudania values (2,  1);
insert into restauracja..menudania values (2,  2);
insert into restauracja..menudania values (2,  3);
insert into restauracja..menudania values (2, 13);
insert into restauracja..menudania values (2, 14);
insert into restauracja..menudania values (2, 15);
insert into restauracja..menudania values (2, 16);
insert into restauracja..menudania values (2, 17);
insert into restauracja..menudania values (3,  1);
insert into restauracja..menudania values (3,  2);
insert into restauracja..menudania values (3,  3);
insert into restauracja..menudania values (3,  5);
insert into restauracja..menudania values (3,  6);
insert into restauracja..menudania values (3, 15);
insert into restauracja..menudania values (3, 17);
insert into restauracja..menudania values (3, 18);
insert into restauracja..menudania values (4,  4);
insert into restauracja..menudania values (4, 22);
insert into restauracja..menudania values (4, 23);
insert into restauracja..menudania values (4, 24);
insert into restauracja..menudania values (5,  1);
insert into restauracja..menudania values (5,  5);
insert into restauracja..menudania values (5, 13);
insert into restauracja..menudania values (5, 15);
insert into restauracja..menudania values (5, 20);
insert into restauracja..menudania values (5, 25);
insert into restauracja..menudania values (5, 26);
insert into restauracja..menudania values (5, 27);
insert into restauracja..menudania values (5, 28);
insert into restauracja..menudania values (6,  1);
insert into restauracja..menudania values (6, 14);
insert into restauracja..menudania values (6, 19);
insert into restauracja..menudania values (6, 20);
insert into restauracja..menudania values (6, 21);
--select * from restauracja..menudania
go

-- Składniki
-- skladnikID, nazwa
insert into restauracja..skladniki values ( 1, 'woda');
insert into restauracja..skladniki values ( 2, 'ryba');
insert into restauracja..skladniki values ( 3, 'drób');
insert into restauracja..skladniki values ( 4, 'wołowina');
insert into restauracja..skladniki values ( 5, 'wieprzowina');
insert into restauracja..skladniki values ( 6, 'chleb');
insert into restauracja..skladniki values ( 7, 'bułka');
insert into restauracja..skladniki values ( 8, 'ser');
insert into restauracja..skladniki values ( 9, 'ziemniaki');
insert into restauracja..skladniki values (10, 'jaja');
insert into restauracja..skladniki values (11, 'cebula');
insert into restauracja..skladniki values (12, 'czosnek');
insert into restauracja..skladniki values (13, 'awokado');
insert into restauracja..skladniki values (14, 'parówka');
insert into restauracja..skladniki values (15, 'kiełbasa');
insert into restauracja..skladniki values (16, 'ryż');
insert into restauracja..skladniki values (17, 'ciasto');
insert into restauracja..skladniki values (18, 'warzywa');
--select * from restauracja..skladniki
go

-- DaniaSkładniki, wiąże dane Danie ze Składnikami
-- danieID, skladnikID
insert into restauracja..daniaskladniki values ( 1,  1);
insert into restauracja..daniaskladniki values ( 2,  1);
insert into restauracja..daniaskladniki values ( 3,  1);
insert into restauracja..daniaskladniki values ( 4,  1);
insert into restauracja..daniaskladniki values ( 5,  1);
insert into restauracja..daniaskladniki values ( 6,  1);
insert into restauracja..daniaskladniki values ( 6,  7);
insert into restauracja..daniaskladniki values ( 7,  6);
insert into restauracja..daniaskladniki values ( 7,  8);
insert into restauracja..daniaskladniki values ( 8,  2);
insert into restauracja..daniaskladniki values ( 8,  9);
insert into restauracja..daniaskladniki values ( 9,  5);
insert into restauracja..daniaskladniki values ( 9,  9);
insert into restauracja..daniaskladniki values (10,  3);
insert into restauracja..daniaskladniki values (10,  5);
insert into restauracja..daniaskladniki values (10,  9);
insert into restauracja..daniaskladniki values (10, 11);
insert into restauracja..daniaskladniki values (11,  4);
insert into restauracja..daniaskladniki values (12,  5);
insert into restauracja..daniaskladniki values (12,  7);
insert into restauracja..daniaskladniki values (12,  8);
insert into restauracja..daniaskladniki values (12, 11);
insert into restauracja..daniaskladniki values (12, 18);
insert into restauracja..daniaskladniki values (13, 10);
insert into restauracja..daniaskladniki values (14, 11);
insert into restauracja..daniaskladniki values (14, 12);
insert into restauracja..daniaskladniki values (14, 18);
insert into restauracja..daniaskladniki values (15, 17);
insert into restauracja..daniaskladniki values (16, 13);
insert into restauracja..daniaskladniki values (16, 18);
insert into restauracja..daniaskladniki values (17,  7);
insert into restauracja..daniaskladniki values (17, 14);
insert into restauracja..daniaskladniki values (18,  8);
insert into restauracja..daniaskladniki values (18, 11);
insert into restauracja..daniaskladniki values (18, 15);
insert into restauracja..daniaskladniki values (18, 17);
insert into restauracja..daniaskladniki values (18, 18);
insert into restauracja..daniaskladniki values (19,  1);
insert into restauracja..daniaskladniki values (19, 18);
insert into restauracja..daniaskladniki values (20, 18);
insert into restauracja..daniaskladniki values (21,  6);
insert into restauracja..daniaskladniki values (21,  8);
insert into restauracja..daniaskladniki values (21, 18);
insert into restauracja..daniaskladniki values (22,  2);
insert into restauracja..daniaskladniki values (22, 16);
insert into restauracja..daniaskladniki values (23,  1);
insert into restauracja..daniaskladniki values (23,  3);
insert into restauracja..daniaskladniki values (23, 18);
insert into restauracja..daniaskladniki values (24,  2);
insert into restauracja..daniaskladniki values (25,  5);
insert into restauracja..daniaskladniki values (25, 17);
insert into restauracja..daniaskladniki values (26,  1);
insert into restauracja..daniaskladniki values (26,  3);
insert into restauracja..daniaskladniki values (26,  4);
insert into restauracja..daniaskladniki values (26, 18);
insert into restauracja..daniaskladniki values (27,  1);
insert into restauracja..daniaskladniki values (27,  4);
insert into restauracja..daniaskladniki values (28,  5);
--select * from restauracja..daniaskladniki
