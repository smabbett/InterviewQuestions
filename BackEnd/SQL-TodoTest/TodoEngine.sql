IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'TodoEngine'
)
BEGIN
    DROP PROCEDURE TodoEngine
END
GO


-- STORED PROCEDURE TO WORKING WITH TODOS
CREATE PROCEDURE TodoEngine
(
  @mode varchar(100) = 'READ', -- CREATE|READ|UPDATE|DELETE
  @userId varchar(100) = NULL,
  @task varchar(100) = NULL,
  @complete bit = 0
)
AS
-- CREATE
  IF (@mode = 'CREATE')
    BEGIN
      -- insert a new todo

      INSERT into Todos (task, isComplete, owner)
      values (@task, 0, @userId)

     
    END
-- READ
  IF (@mode = 'READ')
   BEGIN
      -- select all the correct todos
    SELECT * FROM Todos    
	join Users
    on Users.id = Todos.owner
	WHERE (Users.parent = @userId or Todos.owner = @userId) AND Todos.isComplete is not null  
    ORDER BY Todos.owner
    
  END
  
-- UPDATE 
-- There isn't a taskId in the dataSetup, so I wasn't sure if I should change the dataSetup or just use @task
  IF (@mode = 'UPDATE')
   BEGIN
      update Todos
      set isComplete = @complete
      where Todos.owner = @userId and Todos.task = @task
   END
   
-- DELETE
  IF (@mode = 'DELETE')
    BEGIN
      -- delete a todo, DO NOT REMOVE IT FROM THE DATABASE
	  -- I'm not sure this is the solution, but it keeps it in the database
	  -- also wasn't sure I should change dataSetup to add taskId
	   update Todos
      set isComplete = NULL
      where Todos.owner = @userId and Todos.task = @task
    END
DONE:

-- Try not to change the calls unless you feel it is necessary; the front end team is building against this.
-- You can change the values being passed to the procedure but try to avoid changing the params.

-- mode = READ
-- get all todos that belong to a user and user's children
-- IE, some users have a parent, and that parent can see all the todos of the children
--EXEC TodoEngine @userId='1'
--EXEC TodoEngine @userId='2'
--EXEC TodoEngine @userId='3'

-- mode = CREATE
-- create a new todo
-- EXEC TodoEngine @mode='CREATE', @userId='1', @task='eat second breakfast'

-- mode = UPDATE
-- mark a todo complete
-- EXEC TodoEngine @mode='UPDATE', @userId='1', @taskId='1', @complete='1'

-- mode = DELETE
-- delete a todo, it still needs to be in the db, but is is not returned in the READ mode.
-- EXEC TodoEngine @mode='DELETE', @userId='1', @taskId='1'



