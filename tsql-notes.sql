/* **** D�NG�LER***** */
declare @sayac int = 0

while @sayac <= 10
begin
	if @sayac = 5
		goto EXIT_LOOP

		print @sayac
		set @sayac = @sayac + 1
end

EXIT_LOOP:
print '��kt�m'
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


/* **** BEL�RT�LEN COLUMN'UN TEKRARLANANLARINI S�LER ***** */
DELETE DUP
FROM
(
 SELECT ROW_NUMBER() OVER (PARTITION BY ID ORDER BY ID ) AS Val
 FROM @tmpData
) DUP
WHERE DUP.Val > 1
/* ********************** */

/* **** CURSOR KULLANIMI ***** */
-- MyTablo tablosu i�in bir cursor olu�turuldu
declare t_cursor cursor for select Id from MyTablo;

-- tablo �zerinde dola�abilmek i�in cursor a��ld�
open t_cursor;

-- �zerinde dola��lan tablodan d�nen veriyi kar��lamak i�in de�i�ken olu�turuldu
declare @personelId int;

-- fetch komutu ile tablo �zerinde ilk sat�ra gelindi
fetch next from t_cursor into @personelId;

-- d�nen de�er ekrana yazd�r�ld�
print  cast(@personelId as int)

-- tabloda dola��lacak ba�ka de�er varm� bilgisini verir, e�er "0" ise de�er var e�er "-1" ise okunacak de�er yok demektir
print @@fetch_status

close t_cursor			-- Cursoru kapat�r
deallocate t_cursor	-- Cursoru haf�zadan tamamen siler
/* ********************** */

/* **** CASE KULLANIMI ***** */
SELECT *,Aktifmi= case 
when Aktif=1 then 'Evet' 
when Aktif=0 then 'Hay�r'
end 
FROM MyTablo
/* ********************** */

/* **** IIF KULLANIMI ***** */
SELECT *,Aktifmi= IIF(Aktif=1,'Evet','Hay�r') FROM MyTablo
/* ********************** */

/* **** �K� TABLOYU B�RB�R�NE BA�LAYIP G�NCELLEME ***** */
update  t1 
set t1.Column_Name='new value' 
from Tablo_1 t1,Tablo_2 t2 
where
t2.KayitID = t1.KayitID and t1.Id=134
/* ********************** */

/* **** SAYFALAMA ***** */
/*Kay�tlar� belirli bir say�dan belirli adeti listeler 
  �rne�in tablodaki ilk 5 kay�ttan sonraki 5 kay�t gelsin gibi
  SK�P/TAKE
  */
select * from MyTablo order by ID asc offset 5 rows fetch next 5 rows only
/* ********************** */

/* **** FUNCT�ON ***** */
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

/* **** GER�YE TABLO D�ND�RE FUNCT�ON ***** */
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

/* ****D��ER TABLODA OLMAYAN KAYITLARI L�STELEME  ***** */
select * from Tablo where Id not in(select Id from DigerTablo)
/* ********************** */