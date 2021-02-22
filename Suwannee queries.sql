SELECT p.PatientKEY, p.PatientAccount, p.LastName, p.FirstName, p.MI, p.Sex, p.DOB, p.SS, p.DateOfAccident, p.PatientLanguageKEY, p.CreateDate, p.Inactive,
g.FirstName as GuarantorFirstName, g.LastName as GuarantorLastName, g.SS
FROM Patient p LEFT OUTER JOIN
PatientGuarantor g
ON p.PatientKEY=g.PatientKEY
WHERE p.PatientKEY='624272CC-2D94-4947-8B93-457D590ABB61'

select * FROM ClaimSummary