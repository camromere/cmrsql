/*
Use EMSSQL4

The notes are contained in the dbo.Notes table as well as the dbo.Trip_History table.
To find the note you need to delete, run the following query substituting the date of the note, and in the description put some unique sounding text from the middle of the note between the percent signs and run the query. If it only pulls one record and you verify that is the record you want to delete, the move to the delete section below.
*/

USE RCSQL

/* 
Open up EMSight. Choose company. Pull up My Patient Reports and put in the run number. Scroll down to the bottom and determine the correct Incident #. */
select tdate, job, cmpy, incidentNumber from trips where incidentNumber='16033620'

select code, CAST(NoteDate as DATE) as DateOnly, LEFT(CAST(NoteDate as TIME),5) as TimeOnly, SystemUser, Description
from dbo.Notes 
where NoteDate between '2018-07-03' and '2018-07-04' 
and Description Like '%(Billy Eugene Boler)%'

select * from dbo.Trip_History 
where moddate='2018-07-03' 
and who='CHARIEE.WILKINS'
and tdate='2016-06-01'
and LEFT(CAST(modtime as TIME),5)='16:12'

select * from dbo.Notes where code=574730843 --<== the code comes from the first query and is the [code] field.

/*
TO DELETE THE REQUESTED NOTE
Highlight the following query after putting in the code from the above query corresponding to the actual note you want to delete.

DELETE FROM dbo.Notes
WHERE code=574730843

DELETE FROM dbo.Trip_History
WHERE moddate='2018-07-03' 
and who='CHARIEE.WILKINS'
and tdate='2016-06-01'
and LEFT(CAST(modtime as TIME),5)='16:12'
*/

/*
TO MODIFY THE REQUESTED NOTE
In the following query, put in the code from the above query corresponding to the actual note you want to update. In between the single quotes on the SET Description line, paste the full modified note. Then highlight the UPDATE query and run it.

UPDATE dbo.Notes
SET Description = ''
WHERE code=574730843
*/

USE [RCSQL]
GO

INSERT INTO [dbo].[Notes]
           ([code]
           ,[Description]
           ,[NoteDate]
           ,[SystemUser])
     VALUES
           (574730843
           ,'Email recvd on 07/03/18 in the EstateGroup inbox where Melanie Wood <mwood@guilford-es.com> is requesting a call be placed to Shadonna 609-3261 regarding her fathers account (Billy Eugene Boler). Outreach call placed to Shadonna.  I advised her I was calling her per the request recvd and that we had also spoken last month. Shadonna wanted to speak to someone else. She asked to speak to my Supervisor. I told her I would pass on the call request and her phone number.'
           ,'7/3/2018 16:12'
           ,'CHARIEE.WILKINS')
GO

