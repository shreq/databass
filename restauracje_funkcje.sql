
--use restauracja
use master
go

-- funkcja wyswietlajaca, ile warte byly zamowienia obsluzone przez danego kelnera
-- argumenty: id kelnera
-- argumenty opcjonalne: data od ktorej liczymy, data do ktorej liczymy
drop function zamowieniaKelnera
go
create function zamowieniaKelnera (@IDkelnera int, @dataOd smalldatetime = null, @dataDo smalldatetime = null) returns money
as
begin
	declare @temp money = 0
	set @temp = (
		select sum(d.cena)
		from restauracja..zamowienia as z, restauracja..zamowienieDania as zd, restauracja..menudania as md, restauracja..dania as d,
			restauracja..menu as m, restauracja..restauracje as r, restauracja..personel as p
		where z.zamowienieID = zd.zamowienieID and zd.menudaniaID = md.menudaniaID and md.danieID = d.danieID and md.menuID = m.menuID
			and m.restauracjaID = r.restauracjaID and p.personelID = @IDkelnera and p.restauracjaID = r.restauracjaID
			and z.kelnerID = p.personelID and z.dataZamowienia > case when @dataOd is not null then @dataOd else '1990-01-01' end
			and z.dataZamowienia < case when @dataDo is not null then @dataDo else '2030-01-01' end
		)
	return @temp
end
go
select p.nazwisko, dbo.zamowieniaKelnera(p.personelID, default, default) as [wartosc zamowien]
from restauracja..personel as p, restauracja..stanowiska as s
where p.stanowiskoID = s.stanowiskoID and s.nazwa = 'kelner'
go

-- procedura tworzaca nowe danie i dodajaca je do jednego z menu (domyslne nr 1)
-- argumenty: nazwa, cena, (opcj.) id menu
if exists(select 1 from sys.objects where TYPE = 'P' and name = 'restauracja_dodajDanie')
drop procedure restauracja_dodajDanie
go
create procedure restauracja_dodajDanie @nazwa varchar(10), @cena money, @menu int = 1
as
begin
	declare @ID int = (select top 1 d.danieID from restauracja..dania as d order by d.danieID desc) + 1

	insert into restauracja..dania values (@ID, @nazwa, @cena);

	declare @MenuDaniaID int = (select top 1 md.menudaniaID from restauracja..menudania as md order by md.menudaniaID desc) + 1
	insert into restauracja..menudania values (@MenuDaniaID, @menu, @ID);
end
go
-- nazwa, cena, id menu (opcj.)
exec restauracja_dodajDanie 'kurczak w pieciu smakach', 18, 3
go
exec restauracja_dodajDanie 'kurczak w pieciu smakach', 18
go
select d.danieID, d.nazwa, d.cena, m.menuID
from restauracja..menudania as md, restauracja..dania as d, restauracja..menu as m
where md.danieID = d.danieID and md.menuID = m.menuID


-- procedura modyfikujaca dane pracownika
-- argumenty: id pracownika, nazwa nowego stanowiska, (opcj.) nowa pensja, (opcj.) nowa restauracja
-- zwraca roznice w wynagrodzeniu
if exists(select 1 from sys.objects where TYPE = 'P' and name = 'restauracja_modyfikujPersonel')
drop procedure restauracja_modyfikujPersonel
go
create procedure restauracja_modyfikujPersonel @personelID int, @stanowisko varchar(20), @pensja int = null, @restauracja int = null, @roznica money out
as
begin
	declare @stara_pensja money = (select pensja from restauracja..personel where personelID = @personelID)
	update restauracja..personel
	set stanowiskoID = (select stanowiskoID from restauracja..stanowiska where nazwa = @stanowisko),
		pensja = case when @pensja is not null then @pensja else pensja end,
		restauracjaID = case when @restauracja is not null then @restauracja else restauracjaID end
	where personelID = @personelID
	
	if (@pensja is not null)
		set @roznica = @pensja - @stara_pensja;
	else
		set @roznica = 0;
end
go
declare @out money
-- id pracownika, nazwa nowego stanowiska, (opcj.) nowa pensja, (opcj.) nowa restauracja, wartosc zwracana
declare @id_prac int = 5
exec restauracja_modyfikujPersonel @id_prac, 'szef kuchni', 2200, 3, @out output
print 'Roznica w wynagrodzeniu: ' + cast(@out as varchar)
select p.personelID, p.imie, p.nazwisko, p.stanowiskoID, s.nazwa as [Nazwa stanowiska], p.restauracjaID
from restauracja..personel as p, restauracja..stanowiska as s
where personelID = @id_prac and p.stanowiskoID = s.stanowiskoID
go
declare @out money
-- id pracownika, nazwa nowego stanowiska, (opcj.) nowa pensja, (opcj.) nowa restauracja, wartosc zwracana
declare @id_prac int = 4
exec restauracja_modyfikujPersonel @id_prac, 'szef kuchni', default, default, @out output
print 'Roznica w wynagrodzeniu: ' + cast(@out as varchar)
select p.personelID, p.imie, p.nazwisko, p.stanowiskoID, s.nazwa as [Nazwa stanowiska], p.restauracjaID
from restauracja..personel as p, restauracja..stanowiska as s
where personelID = @id_prac and p.stanowiskoID = s.stanowiskoID
go

-- procedura dajaca podwyzke na podstawie wartosci zamowien dla wszystkich pracownikow danej restauracji
-- jezeli stosunek wartosci zamowien do sumy pensji wynosi tyle, co w podanym argumencie
-- argumenty: id restauracji, wymagany stosunek zamowien do pensji, procentowa wysokosc podwyzki
-- zwraca: wartosc zamowien, sume pensji, informacje o tym, czy podwyzka zostala wprowadzona
if exists(select 1 from sys.objects where TYPE = 'P' and name = 'restauracja_podwyzka')
drop procedure restauracja_podwyzka
go
create procedure restauracja_podwyzka @restauracja int, @stosunek int = 3, @podwyzka float = 0.10,
	@wartoscZamowien money out, @sumaPensji money out, @czyPodwyzka varchar(3) out
as
begin
	set @wartoscZamowien = (
		select sum(d.cena)
		from restauracja..zamowienia as z, restauracja..zamowienieDania as zd, restauracja..menudania as md, restauracja..dania as d,
			 restauracja..menu as m, restauracja..restauracje as r
		where z.zamowienieID = zd.zamowienieID and zd.menudaniaID = md.menudaniaID and md.danieID = d.danieID and md.menuID = m.menuID
			and m.restauracjaID = r.restauracjaID and r.restauracjaID = @restauracja
		group by r.restauracjaID
		)
	
	set @sumaPensji = (
		select sum(pensja)
		from restauracja..personel as p, restauracja..restauracje as r
		where p.restauracjaID = r.restauracjaID and r.restauracjaID = @restauracja
		group by r.restauracjaID
		)

	if (@wartoscZamowien / @sumaPensji > @stosunek)
	begin
		update restauracja..personel
		set pensja = pensja * (1.0 + @podwyzka)
		where restauracjaID = @restauracja
		set @czyPodwyzka = 'TAK';
	end
	else
		set @czyPodwyzka = 'NIE';
end
go

declare @wartoscZamowien money, @sumaPensji money, @czyPodwyzka varchar(3)
declare @id_prac int = 4
declare @id_restauracji int = 1
declare @stosunek int = 4
declare @podwyzka float = 0.15
select * from restauracja..personel as p where p.restauracjaID = @id_restauracji
exec restauracja_podwyzka @id_restauracji, @stosunek, @podwyzka, @wartoscZamowien output, @sumaPensji output, @czyPodwyzka output
print 'Restauracja nr ' + cast(@id_restauracji as varchar) + ', wartosc zamowien: ' + cast(@wartoscZamowien as varchar)
	+ ', suma pensji: ' + cast(@sumaPensji as varchar) + ', czy dano podwyzke: ' + @czyPodwyzka
select * from restauracja..personel as p where p.restauracjaID = @id_restauracji