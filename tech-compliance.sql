SELECT
    l.id AS 'Lead ID',
    l.created_at AS 'Lead ',
    d.name AS 'department',
    u.id AS 'tech id',
    TRIM(u.nickname) AS 'tech nickname',
    case when o.`status` = 1 then 'New'
        when o.`status` = 2 then 'Pending'
        when o.`status` = 3 then 'Won'
        when o.`status` = 4 then 'Lost'
        when o.`status` = 40 then 'Canceled'
        when o.`status` = 5 then 'Closed'
        ELSE '-' END AS 'job status',
    CONCAT(YEAR(l.date), '-',MONTH(l.date)) AS 'month',
    l.date AS 'Appt Date',
    l.reference AS 'Job #',
    concat("https://erp.apollosoft.co/job/ref/",LEFT(l.reference, 6)) AS "Original Job link"
FROM leads l
LEFT JOIN opportunities o ON l.id = o.lead_id
LEFT JOIN users u ON u.id = o.technician_id
LEFT JOIN departments d ON l.department_id = d.id
WHERE (date(l.date) BETWEEN '2021-10-01 00:00:00' AND subdate(current_date, 1))
AND
u.id IS NOT NULL
ORDER BY l.date ASC