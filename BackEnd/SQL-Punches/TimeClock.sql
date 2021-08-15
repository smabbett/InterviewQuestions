CREATE TABLE TimeClock(
Employee varchar(100),
WorkDate varchar(100) ,
Punchtime varchar(100)
)
go


BULK INSERT TimeClock
FROM 'D:\TimeClock.csv'
WITH
(
    FIRSTROW = 2, -- as 1st one is header
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)