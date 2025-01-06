SELECT employee_id, department_id
  FROM Employee
 WHERE CASE WHEN employee_id IN (SELECT employee_id
                                   FROM Employee
                                  GROUP BY employee_id
                                 HAVING COUNT(*) = 1)
                 THEN primary_flag = 'N'
                 ELSE primary_flag = 'Y' END;
