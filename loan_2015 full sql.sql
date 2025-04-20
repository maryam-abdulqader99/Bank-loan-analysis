SELECT * FROM `bank-loans`.loans_2015;
-- key performance indicators (kpi) requirements-- 
-- 1-total loan applications :
select count(member_id)  as total_loan_applications from loans_2015;
-- 2-total application by month:
select monthname(issue_d) as month,count(member_id)  as total_applications from loans_2015
group by month ;
-- month to date total applications (MTD):
select count(member_id)  as MTD_total_loan_applications from loans_2015
WHERE MONTH(issue_d)=12 and year(issue_d)=2015 ;
-- previous month total applications (PMTD) :
select count(member_id)  as PMTD_total_loan_applications from loans_2015
WHERE MONTH(issue_d)=11 and year(issue_d)=2015 ;
-- Total funded amount  :
select sum(funded_amnt) as total_funded_amount from loans_2015;
-- Total funded amount (MTD)  :
select sum(funded_amnt) as MTD_total_funded_amount from loans_2015
WHERE MONTH(issue_d)=12 and year(issue_d)=2015;
-- PREVIOUS MONTH TOTAL FUNDED AMOUNT PMTD:
SELECT sum(FUNDED_AMNT) AS PMT_TOTAL_FUNDED_AMOUNT FROM LOANS_2015 WHERE MONTH(ISSUE_D)=11;
-- total amount recreived :  
select ROUND(sum(total_pymnt),2) as total_amount_received from loans_2015;
-- total amount received from month to date (MTD):
select ROUND(SUM(total_pymnt),2) as MTD_total_amount_received from loans_2015
WHERE MONTH(ISSUE_D)=12 ;
 -- average intrest rate:
 select round(avg(int_rate),2)as Avg_intrest_rate from loans_2015;
 -- month to date average of intrest rate :
  select round(avg(int_rate),2)as Avg_intrest_rate from loans_2015
  WHERE MONTH(ISSUE_D)=12 ;
  -- previous month average intrest rate :
  select round(avg(int_rate),2)as Avg_intrest_rate from loans_2015
  WHERE MONTH(ISSUE_D)=11 ; --  ( this mean the intrest rate has increased from 12.15 to 12.2)
  --  MTD average debt to income ratio (DTI):
  select round(avg(dti),2) as MTD_Avg_DTI from loans_2015
  WHERE MONTH(ISSUE_D)=12 ;
  -- loan status cateories in this data :
select loan_status,(select count(issue_d) ) from loans_2015 group by loan_status;
-- good loan applications :
select count(issue_d) from loans_2015 where loan_status ='current' or loan_status ='In Grace Period';
  -- good loan percentage :
select (select count(issue_d) from loans_2015 where loan_status ='current' or loan_status ='In Grace Period')/(select count(issue_d) from loans_2015)
 *100 as good_loan_percentage;
 -- bad loan applications :
select count(issue_d) from loans_2015 where loan_status ='Default' or loan_status ='Late (31-120 days)' or loan_status = 'Late (16-30 days)';
-- bad loan percentage :
select (select count(issue_d) from loans_2015 where loan_status ='Default' or loan_status ='Late (31-120 days)' or loan_status = 'Late (16-30 days)')/(select count(issue_d) from loans_2015)
*100 as bad_loan_percentage ;
-- good loans funded amount :
select sum(funded_amnt) as good_loan_funded_amount from loans_2015 where loan_status ='current' or loan_status ='In Grace Period';
-- good loan amount received :
select sum(total_pymnt) from loans_2015 where loan_status ='current' or loan_status ='In Grace Period';
-- bad loan funded amount :
select sum(funded_amnt) as good_loan_funded_amount from loans_2015 where loan_status ='Default' or loan_status ='Late (31-120 days)' or loan_status = 'Late (16-30 days)';
-- bad loan amount received :
select sum(total_pymnt) from loans_2015 where loan_status ='Default' or loan_status ='Late (31-120 days)' or loan_status = 'Late (16-30 days)';
-- quick analyzing view :
select
loan_status,
count(issue_d) as Total_applications,
round(sum(total_pymnt),1)as Total_received_amount,
round(sum(funded_amnt),1) as Total_funded_amount,
round(avg(int_rate),1) as Intrest_rate,
round(avg(dti),1) as DTI
from loans_2015 
group by loan_status ;
-- 1- analyzing metrics  by month :
select
monthname(issue_d) as monthname,
count(member_id)  as total_applications,
round(sum(total_pymnt),1)as Total_received_amount,
round(sum(funded_amnt),1) as Total_funded_amount
 from loans_2015 group by monthname ,month(issue_d)
 order by month(issue_d);
-- 2- by state :
select
addr_state as state,
count(member_id)  as total_applications,
round(sum(total_pymnt),1)as Total_received_amount,
round(sum(funded_amnt),1) as Total_funded_amount
from loans_2015
group by  state 
order by total_applications desc ;
-- 3- analyze by term :
select 
term,
count(member_id)  as total_applications,
round(sum(total_pymnt),1)as Total_received_amount,
round(sum(funded_amnt),1) as Total_funded_amount
from loans_2015
group by  term
order by term ;
-- 4- by emloyment lengh :
select
emp_length ,
count(member_id)  as total_applications,
round(sum(total_pymnt),1)as Total_received_amount,
round(sum(funded_amnt),1) as Total_funded_amount
from loans_2015
group by  emp_length
order by total_applications desc ;
-- 5- by purpose :
select
purpose ,
count(member_id)  as total_applications,
round(sum(total_pymnt),1)as Total_received_amount,
round(sum(funded_amnt),1) as Total_funded_amount
from loans_2015
group by  purpose
order by total_applications desc ;
-- 6- by home ownership :
select 
home_ownership ,
count(member_id)  as total_applications,
round(sum(total_pymnt),1)as Total_received_amount,
round(sum(funded_amnt),1) as Total_funded_amount
from loans_2015
group by  home_ownership
order by total_applications desc ;

















