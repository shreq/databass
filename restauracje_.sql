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

-- 1
-- wyswietlenie kierownikow, ich restauracji oraz wielkosci zalogi
select p.personelID, p.imie+' '+p.nazwisko as [kierownik], p.restauracjaID, r.nazwa, (select count(*) from restauracja..personel where restauracjaID = p.restauracjaID) as [wielkosc zalogi] from restauracja..personel as p, restauracja..restauracje as r
where p.restauracjaID = r.restauracjaID AND
	  p.stanowiskoID = 1
go


-- 2
-- wyswietlenie sredniej pensji dla kazdej restauracji
select restauracjaID, ROUND(AVG(pensja), 2) as [srednia pensja] from restauracja..personel
group by restauracjaID
go

-- 3
select *, DATEDIFF(day, p.dataUr, GETDATE())/365.15 from restauracja..personel as p
where DATEDIFF(day, p.dataUr, GETDATE())/365.15 > 50



