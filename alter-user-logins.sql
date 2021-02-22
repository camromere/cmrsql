/* EMSSQL3  =====================================================================================================*/
use RCSQL 
GO
ALTER USER [archive] WITH LOGIN = [archive]
ALTER USER [debsetoffuser] WITH login = [debsetoffuser]
ALTER USER [ems_app_admin] WITH login = [ems_app_admin]
ALTER USER [ems_dso] WITH login = [ems_dso]
ALTER USER [EMSClientPortal] WITH login = [EMSClientPortal]
ALTER USER [emscribe] WITH login = [emscribe]
ALTER USER [EMSMC\carla.romere] WITH login = [EMSMC\carla.romere]
CREATE USER [EMSMC\carla.sa] FOR login  [EMSMC\carla.sa]
ALTER USER [EMSMC\DB_Reporting] WITH login = [EMSMC\DB_Reporting]
ALTER USER [EMSMC\IT Data Management] WITH login = [EMSMC\IT Data Management]
ALTER USER [EMSMC\jason.moffett] WITH login = [EMSMC\jason.moffett]
CREATE USER [EMSMC\RescueNetUsers] FOR LOGIN  [EMSMC\RescueNetUsers]
ALTER USER [EMSMC\sql] WITH login = [EMSMC\sql]
ALTER USER [EMSMC\SQLDistribution] WITH login = [EMSMC\SQLDistribution]
ALTER USER [EMSMC\TripProcessor] WITH login = [EMSMC\TripProcessor]
CREATE USER [EMSMC\Tyler.Pendry] FOR login  [EMSMC\Tyler.Pendry]
ALTER USER [LinkedServer] WITH login = [LinkedServer]
CREATE USER [MembershipPortal] FOR login [MembershipPortal]
CREATE USER [rnbadmin] FOR login [rnbadmin]
ALTER USER [sql] WITH login = [sql]
CREATE USER [linksql4] FOR LOGIN [linksql4]
ALTER USER [automateagent] WITH login = [automateagent]
ALTER USER [brittany.king] WITH login = [brittany.king]
GRANT EXEC ON agent_datetime TO [EMSMC\RescueNet Users]

USE RNB_SUP
GRANT INSERT TO [automateagent];


/* TSTSQL3  =====================================================================================================*/
use RCSQL 
GO
ALTER USER [EMSMC\carla.romere] WITH login = [EMSMC\carla.romere]
ALTER USER [EMSMC\aleksander.panic] WITH login = [EMSMC\aleksander.panic]
ALTER USER [aleksander.panic] WITH LOGIN = [aleksander.panic]
create USER [EMSMC\Domain Users] FOR LOGIN [EMSMC\Domain Users]
CREATE USER [emsbillingcom] FOR login [emsbillingcom]
ALTER USER [emsbillingcom] WITH login = [emsbillingcom]
CREATE USER [emsbillingprod] FOR LOGIN  [emsbillingprod]
ALTER USER [emsbillingprod] WITH login = [emsbillingprod]
ALTER USER [archive] WITH LOGIN = [archive]
ALTER USER [EMSMC\Domain Users] WITH login = [EMSMC\Domain Users]
ALTER USER [ems_app_admin] WITH login = [ems_app_admin]
ALTER USER [ems_dso] WITH login = [ems_dso]
ALTER USER [EMSClientPortal] WITH login = [EMSClientPortal]
ALTER USER [emscribe] WITH login = [emscribe]
ALTER USER [EMSMC\emscribe] WITH login = [EMSMC\emscribe]
ALTER USER [EMSMC\carla.romere] WITH login = [EMSMC\carla.romere]
ALTER USER [EMSMC\DB_Reporting] WITH login = [EMSMC\DB_Reporting]
ALTER USER [EMSMC\IT Data Management] WITH login = [EMSMC\IT Data Management]
ALTER USER [EMSMC\jason.moffett] WITH login = [EMSMC\jason.moffett]
ALTER USER [EMSMC\RescueNetUsers] WITH LOGIN = [EMSMC\RescueNetUsers]
ALTER USER [EMSMC\sql] WITH login = [EMSMC\sql]
ALTER USER [EMSMC\SQLDistribution] WITH login = [EMSMC\SQLDistribution]
ALTER USER [EMSMC\TripProcessor] WITH login = [EMSMC\TripProcessor]
ALTER USER [EMSMC\Tyler.Pendry] WITH login = [EMSMC\Tyler.Pendry]
ALTER USER [EMSPaymentPortal] WITH login = [EMSPaymentPortal]
ALTER USER [MembershipPortal] WITH login = [MembershipPortal]
ALTER USER [rnbadmin] WITH login = [rnbadmin]
ALTER USER [LinkedServer] WITH login = [LinkedServer]
ALTER USER [sql] WITH login = [sql]
GRANT EXEC TO [EMSClientPortal];
GRANT SELECT, REFERENCES ON master.dbo.CSVToList TO PUBLIC;
alter USER [EMSMC\Domain Users] with LOGIN =[EMSMC\Domain Users]

USE EMSmart_Stage2

ALTER USER [EMSMC\carla.romere] WITH login = [EMSMC\carla.romere]
ALTER USER [EMSMC\aleksander.panic] WITH login = [EMSMC\aleksander.panic]
ALTER USER [aleksander.panic] WITH LOGIN = [aleksander.panic]
create USER [EMSMC\Domain Users] FOR LOGIN [EMSMC\Domain Users]
ALTER USER [LinkedServer] WITH login = [LinkedServer]
ALTER USER [EMSMC\sql] WITH login = [EMSMC\sql]
ALTER USER [EMSMC\jason.moffett] WITH login = [EMSMC\jason.moffett]
ALTER USER [emscribe] WITH login = [emscribe]
ALTER USER [EMSClientPortal] WITH login = [EMSClientPortal]
GRANT EXEC TO [EMSClientPortal];


/* TSTSQL4  =====================================================================================================*/
use RCSQL 
GO
GRANT EXEC TO [EMSClientPortal];
GRANT SELECT, REFERENCES ON master.dbo.CSVToList TO PUBLIC;

/* EMSSQL7  =====================================================================================================*/
use RCSQL 
GO
ALTER USER [datamasker] WITH login = [datamasker]
ALTER USER [demo] WITH login = [demo]
ALTER USER [emscribe] WITH login = [emscribe]
ALTER USER [EMSMC\emscribe] WITH login = [EMSMC\emscribe]
ALTER USER [EMSClientPortal] WITH login = [EMSClientPortal]
ALTER USER [EMSecurePayUser] WITH login = [EMSecurePayUser]
ALTER USER [EMSMC\carla.romere] WITH login = [EMSMC\carla.romere]
ALTER USER [sql] WITH login = [sql]
ALTER USER [EMSMC\jason.moffett] WITH login = [EMSMC\jason.moffett]
ALTER USER [EMSMC\heath.landreth] WITH login = [EMSMC\heath.landreth]
ALTER USER [EMSMC\datamasker] WITH login = [EMSMC\datamasker]
ALTER USER [EMSMC\EligibillMagic] WITH login = [EMSMC\EligibillMagic]
ALTER USER [LinkedServer] WITH login = [LinkedServer]

GRANT EXEC TO [EMSClientPortal];
GRANT SELECT, REFERENCES ON master.dbo.CSVToList TO PUBLIC;
GRANT EXEC ON agent_datetime TO [EMSMC\RescueNet Users]

/* OTHER AVAILABLE USERS =========================================================================================*/
ALTER USER [EMSMC\adrianna.cobb] WITH login = [EMSMC\adrianna.cobb]
ALTER USER [EMSMC\RCSQL_Views_Users] WITH LOGIN = [EMSMC\RCSQL_Views_Users]
ALTER USER [EMSMC\Vadim.Sitnic] WITH login = [EMSMC\Vadim.Sitnic]
ALTER USER [svcRedix] WITH login = [svcRedix]
ALTER USER [EMSMC\Brittany King] WITH login = [EMSMC\Brittany King]
ALTER USER [EMSMC\Kimberly Pedersen] WITH login = [EMSMC\Kimberly Pedersen]
ALTER USER [EMSMC\srdjan.drakul] WITH login = [EMSMC\srdjan.drakul]
ALTER USER [EMSMC\vlad.bernstein] WITH login = [EMSMC\vlad.bernstein]
ALTER USER [kimberly.pedersen] WITH login = [kimberly.pedersen]
ALTER USER [SiMX_Stage] WITH login = [SiMX_Stage]
ALTER USER [brittany.king] WITH login = [brittany.king]
ALTER USER [CustomerServiceOutboundDialing] WITH login = [CustomerServiceOutboundDialing]
ALTER USER [datamasker] WITH login = [datamasker]
CREATE USER [EMSPaymentPortal] FOR login [EMSPaymentPortal]

/* TESTSQLRNB RESCUENET USERS TO RESTORE AFTER RESTORING DATABASE */
USE RCSQL;

ALTER USER [archive] WITH login = [archive];
ALTER USER [cryrpt] WITH login = [cryrpt];
ALTER USER [crystalrpt] WITH login = [crystalrpt];
ALTER USER [dbo] WITH login = [dbo];
ALTER USER [debsetoffuser] WITH login = [debsetoffuser];
ALTER USER [emsbillingcom] WITH login = [emsbillingcom];
ALTER USER [emsbillingprod] WITH login = [emsbillingprod];
ALTER USER [EMSClientPortal] WITH login = [EMSClientPortal];
ALTER USER [emscribe] WITH login = [emscribe];
ALTER USER [linkedserver] WITH login = [linkedserver];
ALTER USER [MembershipPortal] WITH login = [MembershipPortal];
ALTER USER [sql] WITH login = [sql];
ALTER USER [TEST\carla.romere] WITH login = [TEST\carla.romere];
ALTER USER [TEST\jason.moffett] WITH login = [TEST\jason.moffett];
ALTER USER [TEST\kim.pedersen] WITH login = [TEST\kim.pedersen];
ALTER USER [TEST\Rescuenet Users] WITH login = [TEST\Rescuenet Users];
ALTER USER [TEST\yury.paulau] WITH login = [TEST\yury.paulau];
ALTER USER [yury.paulau] WITH login = [yury.paulau];

USE OLDAR
ALTER USER [deploy] WITH login = [deploy];
ALTER USER [EMSClientPortal] WITH login = [EMSClientPortal];

