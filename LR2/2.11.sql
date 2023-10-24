USE cd;
SELECT  firstname as 'Firstname/Facilities' FROM members WHERE firstname != 'Guest'
UNION ALL
SELECT facility  FROM facilities;