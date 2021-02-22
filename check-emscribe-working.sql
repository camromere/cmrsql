20-609997
20-609998

SELECT tdate, job, Admitted, Discharged, RunNumber
FROM dbo.Trips
WHERE LEFT(tdate,4)=2020 AND RunNumber IN(609997,609998)