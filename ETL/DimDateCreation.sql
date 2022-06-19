USE [Contoso Direct Sales]





IF EXISTS (SELECT * FROM information_schema.tables WHERE Table_Name = 'DimDate' AND Table_Type = 'BASE TABLE')
	BEGIN
		DROP TABLE [DimDate]
	END;

GO


CREATE TABLE DimDate (
Datekey						Date			not null,
CalendarYear				int				not null,
CalendarMonth				INT				not null,
CalendarHalfYearLabel		nvarchar(20)	not null,
CalendarQuarterLabel		nvarchar(20)	not null,
CalendarMonthLabel			nvarchar(20)	not null,
CalendarWeek				INT				not null,
CalendarDay					int				not null,
CalendarDayOfWeekLabel		nvarchar(10)	not null,
FiscalYear					int				not null,
FiscalHalfYearLabel			nvarchar(20)	not null,
FiscalQuarterLabel			nvarchar(20)	not null,
FiscalMonth					int				not null
constraint PK_ChannelKey Primary key clustered (Datekey ASC)
)


GO

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = '01/01/2000'
SET @EndDate = '01/01/2030'

set nocount on

WHILE @StartDate <= @EndDate
      BEGIN
             INSERT INTO DimDate
             (
			Datekey,
			CalendarYear,
			CalendarMonth,
			CalendarHalfYearLabel,
			CalendarQuarterLabel,
			CalendarMonthLabel,
			CalendarWeek,
			CalendarDay,
			CalendarDayOfWeekLabel,
			FiscalYear,
			FiscalHalfYearLabel,
			FiscalQuarterLabel,
			FiscalMonth
             )
             SELECT
                   @StartDate,
				   YEAR(@StartDate),
				   MONTH(@StartDate),
				   CASE 
				   WHEN	MONTH(@StartDate) IN (1,2,3,4,5,6) THEN 'H1'
				   ELSE 'H2'
				   END AS CalendarHalfYearLabel,  
				   'Q' + CONVERT(VARCHAR(10) ,DATEPART(QUARTER, (@StartDate))),
				   DATENAME(MONTH,@StartDate),
				   DATEPART(WEEK,@StartDate),
				   DATEPART(DAY,@StartDate),
				   DATENAME(WEEKDAY,  @StartDate),
				   DATEPART(year,dateadd(month,-3,@StartDate)),
				   CASE
				   WHEN	MONTH(@StartDate) IN (4,5,6,7,8,9) THEN 'H1'
				   ELSE 'H2'
				   END AS FiscalHalfYearLabel,
				   'Q' + convert(VARCHAR(10),DATEPART(QUARTER, dateadd(month,-3,@StartDate))),
				   DATEpart(MONTH,dateadd(month,-3,@StartDate))	
             
			 
			 SET @StartDate = DATEADD(dd, 1, @StartDate)


      END