/* **** DÖNGÜLER***** */
declare @sayac int = 0

while @sayac <= 10
begin
	if @sayac = 5
		goto EXIT_LOOP

		print @sayac
		set @sayac = @sayac + 1
end

EXIT_LOOP:
print 'Çýktým'
--------------------------------
while @sayac <= 10
begin
	if @sayac = 5
		break

		print @sayac
		set @sayac = @sayac + 1
end
--------------------------------
while @sayac <= 10
	begin

	  set @sayac = @sayac + 1

		if @sayac = 5
		  continue
		
		print @sayac
	end
--------------------------------
while @sayac <> 0
	begin
		print @sayac
		set @sayac = @sayac - 1
	end
--------------------------------
while @sayac <=10
	begin
		print @sayac
		set @sayac = @sayac + 1
	end
/* ********************** */


/* **** BELÝRTÝLEN COLUMN'UN TEKRARLANANLARINI SÝLER ***** */
DELETE DUP
FROM
(
 SELECT ROW_NUMBER() OVER (PARTITION BY ID ORDER BY ID ) AS Val
 FROM @tmpData
) DUP
WHERE DUP.Val > 1
/* ********************** */

/* **** CURSOR KULLANIMI ***** */
-- MyTablo tablosu için bir cursor oluþturuldu
declare t_cursor cursor for select Id from MyTablo;

-- tablo üzerinde dolaþabilmek için cursor açýldý
open t_cursor;

-- üzerinde dolaþýlan tablodan dönen veriyi karþýlamak için deðiþken oluþturuldu
declare @personelId int;

-- fetch komutu ile tablo üzerinde ilk satýra gelindi
fetch next from t_cursor into @personelId;

-- dönen deðer ekrana yazdýrýldý
print  cast(@personelId as int)

-- tabloda dolaþýlacak baþka deðer varmý bilgisini verir, eðer "0" ise deðer var eðer "-1" ise okunacak deðer yok demektir
print @@fetch_status

close t_cursor			-- Cursoru kapatýr
deallocate t_cursor	-- Cursoru hafýzadan tamamen siler
/* ********************** */

/* **** CASE KULLANIMI ***** */
SELECT *,Aktifmi= case 
when Aktif=1 then 'Evet' 
when Aktif=0 then 'Hayýr'
end 
FROM MyTablo
/* ********************** */

/* **** IIF KULLANIMI ***** */
SELECT *,Aktifmi= IIF(Aktif=1,'Evet','Hayýr') FROM MyTablo
/* ********************** */

/* **** ÝKÝ TABLOYU BÝRBÝRÝNE BAÐLAYIP GÜNCELLEME ***** */
update  t1 
set t1.Column_Name='new value' 
from Tablo_1 t1,Tablo_2 t2 
where
t2.KayitID = t1.KayitID and t1.Id=134
/* ********************** */

/* **** SAYFALAMA ***** */
/*Kayýtlarý belirli bir sayýdan belirli adeti listeler 
  Örneðin tablodaki ilk 5 kayýttan sonraki 5 kayýt gelsin gibi
  SKÝP/TAKE
  */
select * from MyTablo order by ID asc offset 5 rows fetch next 5 rows only
/* ********************** */

/* **** FUNCTÝON ***** */
create function Durum(@a int,@b int)
returns nvarchar(10)
as
begin
declare  @sonuc int = @a + @b
	return 
		case
			when @sonuc<0 then 'Negatif'
			when @sonuc>0 then 'Pozitif'
			else '0'
		end
end
/* ********************** */

/* **** GERÝYE TABLO DÖNDÜRE FUNCTÝON ***** */
create function Func(@param int)
RETURNS  @resultTable TABLE 
(
    -- columns returned by the function
    Name nvarchar(100) NOT NULL,
	Surname  nvarchar(100),
	Age int
)
AS
BEGIN
  insert into @resultTable (Name,Surname,Age) values ('Dursun','Katar',27)
END
/* ********************** */

/* ****DÝÐER TABLODA OLMAYAN KAYITLARI LÝSTELEME  ***** */
select * from Tablo where Id not in(select Id from DigerTablo)
/* ********************** */