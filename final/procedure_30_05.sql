# ПРОЦЕДУРА  ИМПОРТА   ТОВАРА
USE [shop]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[PRODUCER_IMPORT]
	(@XMLDATA NTEXT) AS 

DECLARE @HDOC INT
DECLARE	@ID_PRODUCER VARCHAR(16)
DECLARE	@COUNTRY VARCHAR(32)
DECLARE	@NAME VARCHAR(100)
DECLARE @RESULT NVARCHAR(255)

EXEC SP_XML_PREPAREDOCUMENT @HDOC OUTPUT, @XMLDATA OUTPUT

SELECT * INTO #TAB FROM OPENXML(@HDOC, '//row') WITH
(
	ID_PRODUCER VARCHAR(16) 'A',
	COUNTRY VARCHAR(32) 'B',
	[NAME] VARCHAR(100) 'C'
)

EXEC SP_XML_REMOVEDOCUMENT @HDOC

CREATE TABLE #ERRORS (ID_PRODUCER VARCHAR(16),ERROR NVARCHAR(255))

DECLARE CR CURSOR FAST_FORWARD READ_ONLY FOR SELECT * FROM #TAB
OPEN CR

WHILE 1 = 1 BEGIN
	FETCH NEXT FROM CR INTO
	 	@ID_MANUFACTURED,
		@COUNTRY,
		@NAME

	IF @@FETCH_STATUS <> 0 BREAK

	EXEC MANUFACTURED_IMPORT_ONE 
		@COUNTRY,
		@NAME,
		@RESULT OUT	

	IF @RESULT<>''
		INSERT INTO #ERRORS (ID_MANUFACTURED,ERROR) VALUES (@ID_MANUFACTURED,@RESULT)
END

CLOSE CR
DEALLOCATE CR
-- RETURNS ERROR RECORDS
SELECT * FROM #ERRORS

# ПРОЦЕДУРА УДАЛЕНИЯ  ТОВАРА

USE [Shop]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[USP_GOODS_DEL] (@ITEMID BIGINT, @DELETING BIT)
AS

UPDATE GOOD SET DATE_EXCLUDED = CASE WHEN @DELETING = 1 THEN GETDATE() ELSE NULL END
WHERE ID_GOOD = @ITEMID

RETURN 0

## Представления
# Каталог

DROP view catalog;
CREATE view catalog_1 (name, price,produser,country)
as (select
g.name ,
g.price,
m.name,
c.name_short 
from good g
left join manufactured m on m.id = g.manufactured_id 
left join country c on c.id = m.id_country) 

# состав заказа
CREATE view item (number,name_customer,item,delivery, sum_price)
as
 select 
 op.order_id,
 c.name, 
 g.name, 
 d.type_delivery,
 op.total *g.price 
 from order_product op 
 left   join  order o  on  o.id = op.order_id 
 left join customer c on c.id = o.customer_id 
 left  join delivery d  on d.id =o.delivery_id 
 left  join good g on g.id = op.good_id

# выборки

#количество    товара   на  складе
select 
 w.name,
 g.name,
 g.description,
 wg.value 
 from 
 warehouse_good wg 
 left join warehouse w on w.id = wg.warehouse_id is not null
 left  join   good g  on g.id = wg.good_id 
 order by w.name
 
 #max скидка  для  пользователя
 select max(s.final_price),
s.customer
from
 (select 
 d.id,
 g.name as 'good',
 c.name as 'customer',
 d.discount as 'max_discount',
 d.discount*g.price  as 'final_price'
 from  discount d 
 left   join   customer c on c.id = d.customer_id
 left  join good g  on g.id = d.good_id
  )s 
  group by  s.id