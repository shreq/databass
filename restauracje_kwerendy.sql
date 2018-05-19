use master

/*
-- 0
select * from restauracja..restauracje
select * from restauracja..stanowiska
select * from restauracja..personel
select * from restauracja..menu
select * from restauracja..dania
select * from restauracja..menudania
select * from restauracja..skladniki
select * from restauracja..daniaskladniki
go
*/

-- 1 ++
-- wyswietlenie kierownikow, ich restauracji
select p.imie+' '+p.nazwisko as [kierownik], r.nazwa from restauracja..personel as p, restauracja..restauracje as r
where p.restauracjaID = r.restauracjaID AND
	  p.stanowiskoID = 1
go

-- 2 ++
-- wyswietlenie sredniej pensji dla kazdej restauracji
select r.nazwa, ROUND(AVG(pensja), 2) as [srednia pensja] from restauracja..personel as p, restauracja..restauracje as r
where p.restauracjaID = r.restauracjaID
group by p.restauracjaID, r.nazwa
go

-- 3 ++
-- wyswietlenie sredniej pensji dla restauracji w danym miescie
select r.miasto, ROUND(AVG(p.pensja), 2) from restauracja..personel as p, restauracja..restauracje as r
where p.restauracjaID = r.restauracjaID
group by r.miasto
go

-- 4 ++
-- wyswietlenie sredniej pensji dla obu plci
select p.plec, ROUND(AVG(p.pensja), 2) from restauracja..personel as p
group by p.plec
go

-- 5 ++
-- wyswietlenie ile osob danej plci zajmuje dane stanowisko
select s.nazwa,
	   (select count(plec) from restauracja..personel as xp where plec = 'K' AND xp.stanowiskoID = p.stanowiskoID) as [ile kobiet],
	   (select count(plec) from restauracja..personel as xp where plec = 'M' AND xp.stanowiskoID = p.stanowiskoID) as [ile mezczyzn]
from restauracja..personel as p, restauracja..stanowiska as s
where p.stanowiskoID = s.stanowiskoID
group by p.stanowiskoID, s.nazwa
go

-- 6 ++
-- wyswietlenie ceny za najtansze i najdrozsze danie oraz sredniej ceny
select MIN(d.cena) as [najtansze danie], MAX(d.cena) as [najdrozsze danie], ROUND(AVG(d.cena), 2) as [srednia cena z menu]
from restauracja..dania as d, restauracja..menudania as md, restauracja..menu as m, restauracja..restauracje as r
where d.danieID = md.danieID AND md.menuID = m.menuID AND m.restauracjaID = r.restauracjaID AND
	  d.danieID > 5 -- odfiltrowujemy pierwsze 5 rekordów zawierajacych tylko napoje
group by r.restauracjaID
go

-- 7 ++
-- wyswietlenie szefow kuchni ktorzy stosuja w daniach skladniki zawierajace w nazwie 'bul' lub 'e' jako druga litere
select distinct p.imie+' '+p.nazwisko as [szef], r.nazwa
from restauracja..restauracje as r, restauracja..menu as m, restauracja..menudania as md,
	 restauracja..dania as d, restauracja..daniaskladniki as ds, restauracja..skladniki as s,
	 restauracja..personel as p, restauracja..stanowiska as st
where r.restauracjaID = m.restauracjaID AND m.menuID = md.menuID AND md.danieID = d.danieID AND
	  d.danieID = ds.danieID AND ds.skladnikID = s.skladnikID AND r.restauracjaID = p.restauracjaID AND st.stanowiskoID = p.stanowiskoID AND
	  (s.nazwa LIKE '%bul%' OR s.nazwa LIKE '_e%')
	  AND
	  st.nazwa LIKE 'szef kuchni'
go

-- 8 ++
-- aktualny wiek pracownikow
select p.imie, p.nazwisko, FLOOR(DATEDIFF(day, p.dataUr, GETDATE()) / 365.242199) as [wiek] from restauracja..personel as p
order by p.restauracjaID asc, wiek desc

-- 9 --
-- ile trzeba sprzedac dan o sredniej cenie, aby dana restauracja zarobila na pensje zalogi
select p.restauracjaID, SUM(pensja) as [pensje]
from restauracja..personel as p
group by p.restauracjaID


-- coooo
select SUM(pensja) as [pensje], ROUND(AVG(d.cena), 2) as [srednia cena z menu]
from restauracja..dania as d, restauracja..menudania as md, restauracja..menu as m, restauracja..restauracje as r, restauracja..personel as p
where d.danieID = md.danieID AND md.menuID = m.menuID AND m.restauracjaID = r.restauracjaID AND r.restauracjaID = p.restauracjaID
group by r.restauracjaID, p.restauracjaID








