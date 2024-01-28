CREATE PROCEDURE CheckAndInsertCategory
    @CategoryName NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CategoryExists BIT
    SELECT @CategoryExists = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM Categories
    WHERE CategoryName = @CategoryName

    IF @CategoryExists = 0
    BEGIN
        INSERT INTO Categories (CategoryName)
        VALUES (@CategoryName)
        PRINT 'Category added.'
    END
    ELSE
    BEGIN
        PRINT 'this category (' + @CategoryName + ') category tableinda onsuzda exsist.'
    END
END

--test

EXEC CheckAndInsertCategory @CategoryName = 'Elektronika'

EXEC CheckAndInsertCategory @CategoryName = 'Electronics'
