 SELECT  T.Tdate, 
         Cast(LEFT(T.TDate, 4) AS INT) DOS_Year,
		 Cast(Substring(T.TDate, 6, 2) as INT) AS DOS_Month,
		 T.Job, 
		 T.TripID,
		 LTRIM(RTRIM(RIGHT(Datepart(YY,CONVERT(datetime,T.TDATE)),2)+'-'+CAST(T.RUNNUMBER AS CHAR))) AS RunNumber, 

				Case 
					When Datepart(MM, CO.Misc7) > Datepart(MM, T.Tdate) 
						THEN (((12+Datepart(mm, T.Tdate)-Datepart(MM, CO.Misc7))/3)+1)

					WHEN Datepart(MM, CO.Misc7) <= Datepart(MM, T.Tdate) 
						THEN (((Datepart(mm, T.Tdate)-Datepart(MM, CO.Misc7))/3)+1)
				END AS Quarter,

		 T.IncidentNumber AS IncidentNumber,  
		 CO.misc7 AS Client_Fiscal_Year_Start,
		 Cast(LEFT(CO.misc7, 4) as INT) AS Client_Fiscal_Year,
		 Cast(Substring(CO.misc7, 6, 2) as INT) AS Client_Fiscal_Month,
		 CO.Code AS CompanyCode, 
		 C.Name AS CustomerName, 
		 CO.Name AS ClientName, 
		 F.Code AS OrderingFacility_ID,
		 F.Name  AS OrderingFacility, 
		 BS.Code AS Schedule_ID,
		 BS.Descr AS Schedule, 
		 E.Descr AS Event, 
		 TS.Descr AS TripStatus_Desc, 
		 T.Status AS TripStatus,
		 CO.Status AS CompanyStatus,
		 CT.Status AS Call_TypeStatus,
		 P.Status AS PriorityStatus,
		 F.fstatus AS FacilitiesStatus,
		 BS.Status AS Bill_ScheduleStatus,
		 PP.Status AS PayorStatus,
		 TS.Code AS TripStatus_Id,
		 D1.Status AS DiagnosesStatus,
		 CT.Descr AS Call_Type, 
		 P.Descr AS Priority,
		 CT.Descr+'-'+ P.descr	AS LevelOfService, 
		 CASE 
				WHEN CT.Descr+'-'+ P.descr = 'ALS-Emergency' Then 'ALS E'
				WHEN CT.Descr+'-'+ P.descr = 'ALS-Non-Emergency' Then 'ALS NE'
				WHEN CT.Descr+'-'+ P.descr = 'ALS-Treatment/No Transport' Then 'TNT'

				WHEN CT.Descr+'-'+ P.descr = 'ALS2-Emergency' Then 'ALS2'
				WHEN CT.Descr+'-'+ P.descr = 'ALS2-Non-Emergency' Then 'ALS2'
				WHEN CT.Descr+'-'+ P.descr = 'ALS2-Treatment/No Transport' Then 'TNT'

				WHEN CT.Descr+'-'+ P.descr = 'BLS-Emergency' Then 'BLS E'
				WHEN CT.Descr+'-'+ P.descr = 'BLS-Non-Emergency' Then 'BLS NE'
				WHEN CT.Descr+'-'+ P.descr = 'BLS-Treatment/No Transport' Then 'TNT'

				WHEN CT.Descr+'-'+ P.descr = 'SCT-Emergency' Then 'SCT'
				WHEN CT.Descr+'-'+ P.descr = 'SCT-Non-Emergency' Then 'SCT'
				WHEN CT.Descr+'-'+ P.descr = 'SCT-Treatment/No Transport' Then 'TNT'
				ELSE 'OTHER'
		 END AS LOS, 
		 --PPC.Descr AS PrimaryPayerCategory, 
		 CASE WHEN RTRIM(PPC.Descr) = 'Medicare Advantage' THEN 'Medicare'
			  WHEN RTRIM(PPC.Descr) = 'Medicaid MCO'       THEN 'Medicaid'
			  ELSE RTRIM(PPC.Descr)
		END AS PrimaryPayerCategory, 
		 --CPC.Descr AS CurrentPayerCategory, 
		 CASE WHEN RTRIM(CPC.Descr) = 'Medicare Advantage' THEN 'Medicare'
			  WHEN RTRIM(CPC.Descr) = 'Medicaid MCO'       THEN 'Medicaid'
			  ELSE RTRIM(CPC.Descr)
		 END AS CurrentPayerCategory,
		 PT.Descr AS CurrentPayerType,
		 LEFT(PP.Descr,60) AS PrimaryPayer, 
		 LEFT(CP.Descr,60) AS CurrentPayer,
		 
		 CCC.AMOUNT,
		CASE 
				WHEN CCC.CREDIT  = -1  
					THEN CASt(CCC.AMOUNT/100. AS MONEY)
				ELSE 0
					END  AS GrossCharges,

		 T.Addoncost/100. AS AddOnCost, 
		 T.BaSecost/100. AS BaseCost, 
		 T.Miles, 

		CASE 
				WHEN CCC.CREDITTYPE  = -2
					THEN CASt(CCC.AMOUNT/100. AS MONEY)
				WHEN CCC.CREDITTYPE  = -4
					THEN CASt(CCC.AMOUNT/100. AS MONEY)
				ELSE 0
					END  AS ContractualAllowance,

		CASE 
				WHEN CCC.CREDITTYPE  = -3  
					THEN CASt(CCC.AMOUNT/100. AS MONEY)
				ELSE 0
					END  AS RevenueAdjustments,

		CASE 
				WHEN CCC.CREDITTYPE  = 0  
					THEN CASt(CCC.AMOUNT/100. AS MONEY)
				ELSE 0
					END  AS PAYMENTS,

		CASE 
				WHEN CCC.CREDITTYPE  = 1  
					THEN CASt(CCC.AMOUNT/100. AS MONEY)
				ELSE 0
					END  AS WRITEOFF,

		CASE 
				WHEN CCC.CREDITTYPE  = -1  
					THEN CASt(CCC.AMOUNT/100. AS MONEY)
				ELSE 0
					END  AS REFUNDS,
		
		 CASE 
				WHEN T.In_Collections = 0 
					THEN 'No' 
				ELSE 'Yes'
					END AS In_Collection, 
		 T.AgingDate, 
		 CO.NPI, 

		 CASE WHEN T.Tdate < '2015-10-01' THEN D1.ICD9  END AS ICD9_01, 
		 CASE WHEN T.Tdate < '2015-10-01' THEN D1.Descr END AS ICD9_Diagnoses_01,
		 CASE WHEN T.Tdate < '2015-10-01' THEN D2.ICD9  END AS ICD9_02,
		 CASE WHEN T.Tdate < '2015-10-01' THEN D2.Descr END AS ICD9_Diagnoses_02, 
		 CASE WHEN T.Tdate < '2015-10-01' THEN D3.ICD9  END AS ICD9_03,
		 CASE WHEN T.Tdate < '2015-10-01' THEN D3.Descr END AS ICD9_Diagnoses_03,
		 CASE WHEN T.Tdate < '2015-10-01' THEN D4.ICD9  END AS ICD9_04, 
		 CASE WHEN T.Tdate < '2015-10-01' THEN D4.Descr END AS ICD9_Diagnoses_04, 
		 CASE WHEN T.Tdate < '2015-10-01' THEN D5.ICD9  END AS ICD9_05, 
		 CASE WHEN T.Tdate < '2015-10-01' THEN D5.Descr END AS ICD9_Diagnoses_05,

		 CASE WHEN T.Tdate >= '2015-10-01' THEN D1.ICD10  END AS ICD10_01, 
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D1.Descr  END AS ICD10_Diagnoses_01,
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D2.ICD10  END AS ICD10_02, 
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D2.Descr  END AS ICD10_Diagnoses_02,
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D3.ICD10  END AS ICD10_03, 
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D3.Descr  END AS ICD10_Diagnoses_03,
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D4.ICD10  END AS ICD10_04, 
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D4.Descr  END AS ICD10_Diagnoses_04,
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D5.ICD10  END AS ICD10_05, 
		 CASE WHEN T.Tdate >= '2015-10-01' THEN D5.Descr  END AS ICD10_Diagnoses_05,

		 T.EmplIndicator, 
		 T.AccIndicator, 
		 T.CreationRequestTime, 
		 T.PuAddr AS PickUpAddress, 
		 T.PuCity AS PickUPPCity, 
		 T.PuZip AS PickUpZip, 
		 T.DaDdr AS DropOffAddress, 
		 T.DCity AS DropOffCity, 
		 T.DZip AS DropOffZip

 FROM   RCSQL.dbo.TRIPS T 
				  INNER JOIN RCSQL.dbo.Companies CO  ON T.cmpy=CO.code 
					LEFT OUTER JOIN RCSQL.dbo.Call_Types CT  ON T.calltype=CT.code 
					LEFT OUTER JOIN RCSQL.dbo.Priorities P  ON T.priority=P.code 
					LEFT OUTER JOIN RCSQL.dbo.Facilities F  ON T.ofac=F.code 
				  INNER JOIN RCSQL.dbo.Customers C  ON T.custno=C.custno 
					 LEFT OUTER JOIN RCSQL.dbo.Bill_Schedule BS  ON T.schedule=BS.code 
					 LEFT OUTER JOIN RCSQL.dbo.Events E  ON T.event=E.code 
					 LEFT OUTER JOIN RCSQL.dbo.CombinedChargesCredits CCC  ON T.tdate=CCC.tdate AND T.job=CCC.job 
				  INNER JOIN RCSQL.dbo.Payors PP  ON T.Payset=PP.code  -- Primary Payer
				  INNER JOIN RCSQL.dbo.Payors CP  ON T.Payor1=CP.code  -- Current Payer
					 LEFT OUTER JOIN RCSQL.dbo.Descriptions TS  ON T.status=TS.Code  AND TS.Dtype = 11

				 LEFT OUTER JOIN RCSQL.DBO.diagnoses D1 ON T.diag1 = D1.code
				 LEFT OUTER JOIN RCSQL.DBO.diagnoses D2 ON T.diag2 = D2.code
				 LEFT OUTER JOIN RCSQL.DBO.diagnoses D3  ON T.diag3 = D3.code
				 LEFT OUTER JOIN RCSQL.DBO.diagnoses D4  ON T.diag4 = D4.code
				 LEFT OUTER JOIN RCSQL.DBO.diagnoses D5  ON T.diag5 = D5.code


				 INNER JOIN RCSQL.dbo.Payor_Categories PPC  ON PP.Category=PPC.code  -- Primary Payer
				 INNER JOIN RCSQL.dbo.Payor_Categories CPC  ON CP.Category=CPC.code  -- Current Payer
					 LEFT OUTER JOIN RCSQL.dbo.Payor_Types PT  ON CP.systemID = PT.Code -- Current Payer Type

WHERE  (T.tdate>= Convert(date, (DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)) -730)) --DATEADD(month, -24, Convert(Date, GETDATE() -1))
	AND T.tdate<= Convert(date,getdate()))
	AND BS.Code <> 0
