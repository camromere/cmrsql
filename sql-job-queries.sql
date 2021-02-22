SELECT	Name = CAST( j.Name AS VARCHAR(128) ),
				Run_Time = CAST( STUFF( STUFF( STR( h.run_date, 8 ), 7, 0, '-' ), 5, 0, '-' ) + ' ' +
						   STUFF( STUFF( RIGHT( STR( 1000000 + h.Run_Time, 7 ), 6 ), 5, 0, ':' ), 3, 0, ':' ) AS DATETIME ),
				Run_Duration_Sec = h.run_duration % 100 + h.run_duration / 100 % 100 * 60. + h.run_duration / 10000 * 3600.,
				s.freq_type, s.active_start_time, s.freq_interval
		FROM	msdb.dbo.sysjobhistory h JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
		INNER JOIN msdb.dbo.sysjobschedules js ON j.job_id=js.job_id
		INNER JOIN msdb.dbo.sysschedules s ON js.schedule_id=s.schedule_id
		WHERE	h.step_id = 0

SELECT j.name, j.category_id, j.notify_level_email, j.notify_level_page, j.notify_email_operator_id, j.notify_page_operator_id, j.version_number, 
js.next_run_date, js.next_run_time FROM msdb.dbo.sysjobhistory h JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
		INNER JOIN msdb.dbo.sysjobschedules js ON j.job_id=js.job_id
		INNER JOIN msdb.dbo.sysschedules s ON js.schedule_id=s.schedule_id
		--INNER JOIN master.sys.databases md ON 
WHERE j.enabled=1
