CREATE PROCEDURE InsertProductWithCategory
    @CategoryName NVARCHAR(255),
    @Description NVARCHAR(1000),
    @ProductName NVARCHAR(255),
    @UnitPrice DECIMAL(18, 2),
    @UnitsInStock INT
AS
BEGIN
    DECLARE @CategoryId INT
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @CategoryName)
    BEGIN
        INSERT INTO Categories (CategoryName, Description)
        VALUES (@CategoryName, @Description)
        SET @CategoryId = SCOPE_IDENTITY()
    END
    ELSE
    BEGIN
       
        SELECT @CategoryId = CategoryId FROM Categories WHERE CategoryName = @CategoryName
    END


    INSERT INTO Products (ProductName, UnitPrice, UnitsInStock, CategoryId)
    VALUES (@ProductName, @UnitPrice, @UnitsInStock, @CategoryId)
END


--test
EXEC InsertProductWithCategory 
    @CategoryName = 'Elektronika',
    @Description = 'Elektronika',
    @ProductName = 'Laptop',
    @UnitPrice = 500,
    @UnitsInStock = 10

EXEC InsertProductWithCategory 
    @CategoryName = 'Ayyaqqabi',
    @Description = 'Geyim',
    @ProductName = 'Şəpiy',
    @UnitPrice = 12,
    @UnitsInStock = 50
