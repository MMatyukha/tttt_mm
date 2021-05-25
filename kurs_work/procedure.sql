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

UPDATE GOODS SET DATE_EXCLUDED = CASE WHEN @DELETING = 1 THEN GETDATE() ELSE NULL END
WHERE ID_GOODS = @ITEMID

RETURN 0

## Представления
# Каталог

DROP view catalog;
CREATE view catalog (name, avg_price)
as select g.name,avg(g.price) 
from goods g 
GROUP by 1;

CREATE view item (name, sum_price)
as select 
c.name,
SUM(op.total)
from customers c 
right join orders o on o.customer_id = c.id 
right join orders_products op on op.order_id = o.id 
GROUP by op.order_id ;

# выборки
SELECT 
g.name as 'наименование',
g.description  as 'описание',
m.NAME as 'производитель',
c.name_short 'страна  происхождения'
from  goods g 
left  join  manufactured m on m.id = g.manufactured_id 
left  join country c on  c.id = m.ID_COUNTRY
order by c.id ;

SELECT 
max(op.total),
c.name 
from orders_products op
left join  orders o on  o.id =op.order_id 
left join customers c on c.id=o.customer_id 
GROUP by o.id