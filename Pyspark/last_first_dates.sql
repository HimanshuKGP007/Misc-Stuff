SQL> 
SQL> select last_day(add_months(sysdate,-1)) from dual;

LAST_DAY
--------
28.02.10

SQL> select trunc(add_months(sysdate,-1),'MM') from dual

TRUNC(AD
--------
01.02.10

SQL>

-- https://community.oracle.com/tech/developers/discussion/1050998/extract-first-and-last-date-of-previous-month
-- https://stackoverflow.com/questions/45809743/best-practices-to-get-first-date-and-last-date-of-previous-month-in-oracle 


-- 2nd method

select  TRUNC(ADD_MONTHS(SYSDATE, -1),'MM')  from dual ; 
SELECT last_day(add_months(trunc(sysdate,'mm'),-1)) FROM DUAL;
