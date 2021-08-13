bulk insert TimeClock 
from '/TimeClock.csv' with (
    fieldterminator = ',',
    rowterminator = '\n'
)
go

select * from TimeClock
-- need to combine punchtimes, sort by employee and date