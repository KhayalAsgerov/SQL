CREATE FUNCTION dbo.CheckAgeCompletionn
(
    @BirthDate DATE,
    @Age INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @ResultMessage NVARCHAR(MAX)
	
	DECLARE @YearDiff INT, @MonthDiff INT, @DayDiff INT

    SELECT 
        @YearDiff = DATEDIFF(YEAR, @BirthDate, GETDATE()),
        @MonthDiff = DATEDIFF(MONTH, @BirthDate, GETDATE()) % 12,
        @DayDiff = DATEDIFF(DAY, @BirthDate, GETDATE())

 IF @YearDiff >= @Age
    BEGIN
        IF @MonthDiff > 0 AND @DayDiff > 0
            SET @ResultMessage = 'yasi ay ve gun olaraq tammlanmayib'
        ELSE IF @MonthDiff = 0 AND @DayDiff > 0
            SET @ResultMessage = 'yasi gun olaraq tamamlanmayib'
        ELSE
            SET @ResultMessage = 'il ay ve gun olaraq yasin tamamlamayib'
    END
    ELSE
        SET @ResultMessage = 'bu yasa catmayib'

    RETURN @ResultMessage
END


---- Test

SELECT dbo.CheckAgeCompletionn('1999-01-01', 25) AS Result

SELECT dbo.CheckAgeCompletionn('1992-05-15', 30) AS Result

SELECT dbo.CheckAgeCompletionn('2006-08-20', 18) AS Result