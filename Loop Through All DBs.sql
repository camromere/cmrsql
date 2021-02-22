EXECUTE sp_msforeachdb 'USE ? IF DB_NAME() NOT IN("master","msdb","tempdb","model") BACKUP DATABASE ? TO DISK = "G:?.bak, WITH INIT"';
 
/* The ? gets replaced with the database name.
So that will backup any user database to the the G: drive.
 
This can simplify any looping code you have. */
