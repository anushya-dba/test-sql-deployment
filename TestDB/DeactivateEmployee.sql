CREATE PROCEDURE [dbo].[DeactivateEmployee]
    @EmployeeId INT
AS
BEGIN
    UPDATE [dbo].[Employee]
    SET [IsActive] = 0
    WHERE [Id] = @EmployeeId;
END;