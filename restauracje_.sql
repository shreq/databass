-- 0
select * from restauracja..dania
select * from restauracja..daniaskladniki
select * from restauracja..menu
select * from restauracja..menudania
select * from restauracja..personel
select * from restauracja..restauracje
select * from restauracja..skladniki
select * from restauracja..stanowiska
go

-- 1
-- wyswietlenie kierownikow i ich restauracji
select p.personelID, p.imie+' '+p.nazwisko as [imie nazwisko], p.restauracjaID, r.nazwa from restauracja..personel as p, restauracja..restauracje as r
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



