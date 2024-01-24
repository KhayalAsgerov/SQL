CREATE FUNCTION FormatPhoneNumber(@PhoneNumber NVARCHAR(20))
RETURNS NVARCHAR(20)
AS
BEGIN
DECLARE @FormattedPhoneNumber NVARCHAR(20);
    SET @PhoneNumber = REPLACE(@PhoneNumber, ' ', '');
    SET @PhoneNumber = REPLACE(@PhoneNumber, '-', '');
    SET @PhoneNumber = REPLACE(@PhoneNumber, '(', '');
    SET @PhoneNumber = REPLACE(@PhoneNumber, ')', '');

  -- Control
    IF PATINDEX('%[^0-9]%', @PhoneNumber) > 0 OR LEN(@PhoneNumber) < 9
    BEGIN
        RETURN NULL;
    END;

    -- Standart Format
    SET @FormattedPhoneNumber = '+994 (' + SUBSTRING(@PhoneNumber, LEN(@PhoneNumber) - 9, 2) + ') ' +
                                SUBSTRING(@PhoneNumber, LEN(@PhoneNumber) - 7, 3) + ' ' +
                                SUBSTRING(@PhoneNumber, LEN(@PhoneNumber) - 4, 2) + ' ' +
                                SUBSTRING(@PhoneNumber, LEN(@PhoneNumber) - 2, 2);

    RETURN @FormattedPhoneNumber;
END;


-- Check
SELECT dbo.FormatPhoneNumber('0501112222') AS FormattedNumber1;
SELECT dbo.FormatPhoneNumber('501112222') AS FormattedNumber2;
SELECT dbo.FormatPhoneNumber('9940501112222') AS FormattedNumber3;
SELECT dbo.FormatPhoneNumber('+9940501112222') AS FormattedNumber4;
SELECT dbo.FormatPhoneNumber('123') AS FormattedNumber5; -- Geçersiz numara, NULL dönmeli
