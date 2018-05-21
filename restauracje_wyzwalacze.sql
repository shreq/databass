use restauracja
go

-- wyzwalacz usuwajacy pracownikow
-- instead of delete
drop trigger restauracja_usunPracownika
go
create trigger restauracja_usunPracownika
on restauracja..personel
instead of delete
as
    set nocount on
	update restauracja..personel set kierownikID = null where kierownikID in (select personelID from deleted)
	delete from restauracja..personel where personelID in (select personelID from deleted)

	insert into restauracja..personel_archiw select * from deleted
	update restauracja..personel_archiw set dataZwolnienia = getdate() where dataZwolnienia is null and personelID in (select personelID from deleted)
go

delete from restauracja..personel
where personelID = 1 or personelID = 2
select * from restauracja..personel
select * from restauracja..personel_archiw
go

-- wyzwalacz sprawdzajacy cene dania przy jego dodawaniu do menu
-- jezeli cena dania przekracza maksymalna cene okreslona dla restauracji, to nie zostanie dodane do menu
-- instead of insert
drop trigger sprawdzCene
go
create trigger sprawdzCene
on restauracja..menudania
instead of insert
as
	declare @cenaDania money = (
		select d.cena
		from inserted as i, restauracja..dania as d
		where i.danieID = d.danieID)

	declare @maxCena money = (
		select r.maxCena
		from inserted as i, restauracja..menu as m, restauracja..restauracje as r
		where i.menuID = m.menuID and m.restauracjaID = r.restauracjaID)

	if ( @cenaDania < @maxCena )
	begin
		insert into restauracja..menudania select * from inserted
	end
	else
	begin
		print 'Cena jest za wysoka! Nie mozna dodac dania do menu ('
			+ cast(@cenaDania as varchar) + ' > ' + cast(@maxCena as varchar) + ')'
	end
go

-- danieID, nazwa, cena
insert into restauracja..dania values (100, 'danie testowe', 150);
insert into restauracja..dania values (101, 'danie testowe 2', 15);
-- menudaniaID, menuID, danieID
insert into restauracja..menudania values (100, 1, 100);
insert into restauracja..menudania values (101, 1, 101);
go
select d.danieID, d.nazwa, d.cena
from restauracja..menudania as md, restauracja..dania as d, restauracja..menu as m
where md.danieID = d.danieID and md.menuID = m.menuID and m.menuID = 1
go

-- wyzwalacz po aktualizacji widelek pensji dla danego stanowiska
-- sprawdza, czy pensje pracownikow mieszcza sie w nowym przedziale
-- jezeli nie, to zmienia wartosc pensji
-- after update
drop trigger aktualizujPensje
go
create trigger aktualizujPensje
on restauracja..stanowiska
after update
as
	declare @placa_max money = (select placa_max from inserted)
	declare @placa_min money = (select placa_min from inserted)

	declare kursor cursor for (select personelID from restauracja..personel where stanowiskoID = (select stanowiskoID from inserted))
	open kursor
	declare @x int
	declare @pom money
	fetch next from kursor into @x
	while (@@FETCH_STATUS = 0)
	begin
		set @pom = (select pensja from restauracja..personel where personelID = @x)
		if (@pom > @placa_max)
		begin
			print 'Placa pracownika o ID ' + cast(@x as varchar) + ' jest za wysoka! Obnizono place z ' + cast(@pom as varchar)
				+ ' do ' + cast(@placa_max as varchar)
			update restauracja..personel
			set pensja = @placa_max
			where personelID = @x
		end
		if (@pom < @placa_min)
		begin
			print 'Placa pracownika o ID ' + cast(@x as varchar) + ' jest za niska! Podwyzszono place z ' + cast(@pom as varchar)
				+ ' do ' + cast(@placa_min as varchar)
			update restauracja..personel
			set pensja = @placa_min
			where personelID = @x
		end
		fetch next from kursor into @x
	end
	close kursor
	deallocate kursor
go

update restauracja..stanowiska
set placa_max = 1100.00
where nazwa = 'kelner'
go
update restauracja..stanowiska
set placa_min = 2500.00
where nazwa = 'szef kuchni'
go
select p.personelID, p.imie, p.nazwisko, p.pensja, s.nazwa
from restauracja..personel as p, restauracja..stanowiska as s
where p.stanowiskoID = s.stanowiskoID and (s.nazwa = 'kelner' or s.nazwa = 'szef kuchni')

use master
go
