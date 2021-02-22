SELECT ADayBack.datetime_local, ADayBack.action, ADayBack.data,
    ADayBack.traceName, ADayBack.category_id, ADayBack.ObjectType
    FROM dbo.SeeAccessControlChanges
        (DateAdd(DAY, -25, SysDateTime()), SysDateTime()
        ) AS ADayBack
          ORDER BY datetime_local asc;