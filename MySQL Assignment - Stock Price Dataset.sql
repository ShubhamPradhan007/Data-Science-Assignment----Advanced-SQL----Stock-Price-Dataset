/*  The dataset being worked upon here contains Stock price data from 1-Jan-2015 to 31-July-2018 from NSE Website.
It is for the stocks namely Eicher Motors, Hero, Bajaj Auto, TVS Motors, Infosys and TCS. */

# Creating the schema named "Assignment" here
# Also the importing of the respective CSV files has been done accordingly using the Table Data Import Wizard.

create database Assignment;
use Assignment;

# Q1. Create a new table named 'bajaj1' and likewise containing the date, close price, 20 Day MA and 50 Day MA for all stocks

###   BAJAJ   ###
desc bajaj;

# We see that the Date field contains string values, therefore, we need to modify the datatype to Date

SET SQL_SAFE_UPDATES = 0;   # This is used to perform any updation while in safe mode

UPDATE `bajaj`
SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');
alter table bajaj modify column `date` date;

# Creating the table 'bajaj1'
create table bajaj1 as
(select `Date`, `Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS between 19 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS between 49 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `50 Day MA`
from bajaj
window w as (ORDER BY DATE));

# Lets view a sample of the created table
select * from bajaj1
limit 50;


###    EICHER   ###
# Now, proceeding further to create table 'eicher1'
desc eicher;

#updating the datatype of the date field
UPDATE `eicher`
SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');
alter table eicher modify column `date` date;

# Creating the table 'eicher1'
create table eicher1 as
(select `Date`, `Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS between 19 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS between 49 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `50 Day MA`
from eicher
window w as (ORDER BY DATE));

# Lets view a sample of the created table
select * from eicher1
limit 50;


###    HERO   ###
# Now, lets proceed with creating the table 'hero1'
desc hero;

# updating the date field
UPDATE `hero`
SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');
alter table `hero` modify column `Date` date;

# Creating the table 'hero1'
create table hero1 as
(select `Date`, `Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS between 19 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS between 49 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `50 Day MA`
from hero
window w as (ORDER BY DATE));

# Lets view a sample of the created table
select * from hero1
limit 50;


###   INFOSYS   ###
# Now, proceeding with creating the table 'infosys1'
desc infosys;

#updating the date field
UPDATE `infosys`
SET `Date` = STR_TO_DATE(`Date`, '%d-%M-%Y');
ALTER TABLE `infosys` MODIFY COLUMN `Date` date;

# Creating the table 'infosys1'
create table infosys1 as
(select `Date`, `Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS between 19 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS between 49 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `50 Day MA`
from infosys
window w as (ORDER BY DATE));

# Lets view a sample of the created table
select * from infosys1
limit 50;


###  TCS  ###
# Now, proceeding with creating the table 'tcs1'
desc tcs;

#updating the date field
UPDATE `tcs`
SET `Date` = STR_TO_DATE(`Date`, '%d-%M-%Y');
ALTER TABLE `tcs` MODIFY COLUMN `Date` date;

# Creating the table 'tcs1'
create table tcs1 as
(select `Date`, `Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS between 19 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS between 49 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `50 Day MA`
from tcs
window w as (ORDER BY DATE));

# viewing a sample of the created table 'tvs1'
select * from tcs1
limit 50;


## TVS  ## 
# Now, proceeding with creating the table 'tvs1'
desc tvs;

#updating the date field
UPDATE `tvs`
SET `Date` = STR_TO_DATE(`Date`, '%d-%M-%Y');
ALTER TABLE `tvs` MODIFY COLUMN `Date` date;

# Creating the table 'tvs1'
create table tvs1 as
(select `Date`, `Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS between 19 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS between 49 PRECEDING AND CURRENT ROW) 
	ELSE NULL 
END AS `50 Day MA`
from tvs
window w as (ORDER BY DATE));

# viewing a sample of the created table 'tvs1'
select * from tvs1
limit 50;


/*  Q2.  Create a master table containing the date and close price of all the six stocks. 
(Column header for the price is the name of the stock)  */

## Creating the Master table containing the date and close price of all the six stocks

CREATE TABLE master as 
(select b.date Date, 
b.`Close Price` Bajaj, 
tc.`Close Price` TCS, 
tv.`Close Price` TVS, 
i.`Close Price` Infosys,
e.`Close Price` Eicher,
h.`Close Price` Hero 
from bajaj1 b inner join tcs1 tc 
	on b.date = tc.date
inner join tvs1 tv 
	on tc.date = tv.date
inner join infosys1 i 
	on i.date = tv.date
inner join eicher1 e 
	on e.date = i.date
inner join hero1 h
	on h.date = e.date
);

# viewing the master table
desc master;
select * from master
limit 10;

/*  Q3. Use the table created in Part(1) to generate buy and sell signal. 
Store this in another table named 'bajaj2'. Perform this operation for all stocks. */

# Creating the table 'bajaj2'
CREATE TABLE bajaj2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'Buy'
    WHEN `20 Day MA`<`50 Day MA` then 'Sell'
    ELSE 'Hold'
END AS `Signal` 
from bajaj1);

# viewing the created table 'bajaj2'
select * from bajaj2
limit 50;


# Now, Creating the table 'eicher2'
CREATE TABLE eicher2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'Buy'
    WHEN `20 Day MA`<`50 Day MA` then 'Sell'
    ELSE 'Hold'
END AS `Signal` 
from eicher1);

# viewing the created table 'eicher2'
select * from eicher2
limit 50;


# Now, Creating the table 'hero2'
CREATE TABLE hero2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'Buy'
    WHEN `20 Day MA`<`50 Day MA` then 'Sell'
    ELSE 'Hold'
END AS `Signal` 
from hero1);

# viewing the created table 'hero2'
select * from hero2
limit 50;


# Now, Creating the table 'infosys2'
CREATE TABLE infosys2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'Buy'
    WHEN `20 Day MA`<`50 Day MA` then 'Sell'
    ELSE 'Hold'
END AS `Signal` 
from infosys1);

# viewing the created table 'infosys2'
select * from infosys2
limit 50;


# Now, Creating the table 'tcs2'
CREATE TABLE tcs2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'Buy'
    WHEN `20 Day MA`<`50 Day MA` then 'Sell'
    ELSE 'Hold'
END AS `Signal` 
from tcs1);

# viewing the created table 'tcs2'
select * from tcs2
limit 50;


# Now, Creating the table 'tvs2'
CREATE TABLE tvs2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'Buy'
    WHEN `20 Day MA`<`50 Day MA` then 'Sell'
    ELSE 'Hold'
END AS `Signal` 
from tvs1);

# viewing the created table 'tvs2'
select * from tvs2
limit 50;


/*  Q4. Create a User defined function, that takes the date as input and 
returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.  */

# Creating the user defined function as BajajStock_Signal_for_day to return the signal for a particular input date
CREATE FUNCTION BajajStock_Signal_for_day(d date)
RETURNS char(4) 
DETERMINISTIC
RETURN (select `Signal` from bajaj2 where date=d);


#Testing sample cases
select BajajStock_Signal_for_day('2015-01-01');  # For Hold Signal
select BajajStock_Signal_for_day('2015-08-24');  # For Sell Signal
select BajajStock_Signal_for_day('2015-05-18');  # For Buy Signal