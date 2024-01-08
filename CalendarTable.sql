-- creating the table calendar
DROP TABLE IF EXISTS Calendar;

CREATE TABLE Calendar
(
	[Date] DATE NOT NULL,
	[Year] SMALLINT NOT NULL,
	[Month] TINYINT NOT NULL,
	[MonthName] VARCHAR(10) NOT NULL,
	[Day] TINYINT NOT NULL,
	[DayName] VARCHAR(10) NOT NULL,
	[DayOfWeek] TINYINT NOT NULL,
	IsWeekend BIT NOT NULL
);

-- declaring the start date of calendar
DECLARE @startdate DATE
SET @startdate = '2024-01-01';

-- declaring the end date of calendar
DECLARE @enddate DATE
SET @enddate = DATEADD(YEAR, 3, DATEFROMPARTS(2024, 12, 31));

-- inserting data into the table using a while loop
WHILE @startdate <= @enddate
	BEGIN
		INSERT INTO Calendar
			SELECT 
				@startdate,
				DATEPART(YEAR, @startdate),
				DATEPART(MONTH, @startdate),
				DATENAME(MONTH, @startdate),
				DATEPART(DAY, @startdate),
				DATENAME(weekday, @startdate),
				DATEPART(weekday, @startdate),
				CASE WHEN DATEPART(weekday, @startdate) in (1,7) THEN 1 
				ELSE 0
				END
		SET @startdate = DATEADD(DAY, 1, @startdate)
	END;

-- checking if the calendar has been generated
SELECT *
FROM Calendar;