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
print 'Çiktim'
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


/* **** BELIRTILEN COLUMN'UN TEKRARLANANLARINI SILER ***** */
DELETE DUP
FROM
(
 SELECT ROW_NUMBER() OVER (PARTITION BY ID ORDER BY ID ) AS Val
 FROM @tmpData
) DUP
WHERE DUP.Val > 1
/* ********************** */

/* **** CURSOR KULLANIMI ***** */
-- MyTablo tablosu için bir cursor oluşturuldu
declare t_cursor cursor for select Id from MyTablo;

-- tablo üzerinde dolaşabilmek için cursor açildi
open t_cursor;

-- üzerinde dolaşilan tablodan dönen veriyi karşilamak için değişken oluşturuldu
declare @personelId int;

-- fetch komutu ile tablo üzerinde ilk satira gelindi
fetch next from t_cursor into @personelId;

-- dönen değer ekrana yazdirildi
print  cast(@personelId as int)

-- tabloda dolaşilacak başka değer varmi bilgisini verir, eğer "0" ise değer var eğer "-1" ise okunacak değer yok demektir
print @@fetch_status

close t_cursor			-- Cursoru kapatir
deallocate t_cursor	-- Cursoru hafizadan tamamen siler
/* ********************** */

/* **** CASE KULLANIMI ***** */
SELECT *,Aktifmi= case 
when Aktif=1 then 'Evet' 
when Aktif=0 then 'Hayir'
end 
FROM MyTablo
/* ********************** */

/* **** IIF KULLANIMI ***** */
SELECT *,Aktifmi= IIF(Aktif=1,'Evet','Hayir') FROM MyTablo
/* ********************** */

/* **** IKI TABLOYU BIRBIRINE BAĞLAYIP GÜNCELLEME ***** */
update  t1 
set t1.Column_Name='new value' 
from Tablo_1 t1,Tablo_2 t2 
where
t2.KayitID = t1.KayitID and t1.Id=134
/* ********************** */

/* **** SAYFALAMA ***** */
/*Kayitlari belirli bir sayidan belirli adeti listeler 
  Örneğin tablodaki ilk 5 kayittan sonraki 5 kayit gelsin gibi
  SKIP/TAKE
  */
select * from MyTablo order by ID asc offset 5 rows fetch next 5 rows only
/* ********************** */

/* **** FUNCTION ***** */
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

/* **** GERIYE TABLO DÖNDÜREN FUNCTION ***** */
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

/* ****DIĞER TABLODA OLMAYAN KAYITLARI LISTELEME  ***** */
select * from Tablo where Id not in(select Id from DigerTablo)
/* ********************** */
