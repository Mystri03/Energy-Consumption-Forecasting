create database energy_db;
use energy_db;

# Q1 View First 10 Records
select * from power_consumption limit 10;

# Q2 Filter High Active Power Usage
select * from power_consumption where Global_active_power > 5;

# Q3 What is the total electricity consumption recorded?
select sum(Global_active_power) as total_active_power from power_consumption;

# Q4 What is the average active power consumption?
select avg(Global_reactive_power) as average_power from power_consumption;

# Q5 What is the average voltage recorded?
select avg(Voltage) as average_voltage from power_consumption;

# Q6 What is the maximum and minimum global intensity observed?
select min(Global_intensity) as min_intens, max(Global_intensity) as max_interns from power_consumption;

# Q7 Retrieve records where voltage is above 220V (high voltage condition)
select * from  power_consumption where Voltage > 220;
   
# Q8 Find total power consumption for a specific date (Date: '20-01-2007')
select Date, sum(Global_active_power) as total_power from power_consumption where Date = '20-01-2007' group by Date;

# Q9 Count total number of records
select count(*) as total_records from power_consumption;

# Q10 Find days where Energy Efficiency Score is below 0.5
select Date, Energy_efficiency_score from power_consumption where Energy_efficiency_score < 0.5;

# Q11 Total sub-metering consumption by type
select sum(Sub_metering_1) as kitchen_usage, sum(Sub_metering_2) as laundry_usage, sum(Sub_metering_3) as heating_usage
from power_consumption;

# Q12 Find top 10 highest power consumption records
select * from power_consumption order by Global_active_power desc limit 10;

# Q13 What is the average unmetered power?
select avg(Unmetered_power) as unmetered_p from power_consumption;

# Q14 Daily total electricity consumption
select Date, sum(Global_active_power) as total_power from power_consumption group by  Date order by Date;

# Q15 Find days where daily consumption exceeded 100 kW
select Date, sum(Global_active_power) as total_power from power_consumption group by Date having total_power > 100;

# Q16 Average energy efficiency score per day
select Date, avg(Energy_efficiency_score) as avg_enery_score from power_consumption group by Date;

# Q17 Which sub-metering contributes most overall?
select  'Sub_metering_1' as meter, sum(Sub_metering_1) as total from power_consumption
union all 
select 'Sub_metering_2', SUM(Sub_metering_2) from power_consumption
union all 
select 'Sub_metering_3', SUM(Sub_metering_3) from power_consumption
order by total desc;

# Q18 Average power-to-voltage ratio per day
select Date, avg(Power_to_Voltage_ratio) as p_v_r from power_consumption group by Date;

# Q19 Count records where reactive power is more than 50% of active power
select count(*) high_reactive  from power_consumption where Reactive_to_Active_ratio > 0.5;

# Q20 Find peak consumption hour
select Power_time, sum(Global_active_power) as total_power from power_consumption 
group by Power_time order by total_power desc limit 1;

# Q22 Days where unmetered power is unusually high (> average)
select Date, Unmetered_power from power_consumption 
where Unmetered_power > (select avg(Unmetered_power) from power_consumption);

# Q23 Total daily unmetered power
select Date, sum(Unmetered_power) as total_unmetered from power_consumption group by Date order by total_unmetered desc;

# Q24 Find dates where average voltage dropped below 215V
select Date, avg(Voltage) as avg_v from power_consumption
group by Date having avg(Voltage) < 215;

# Q25 Identify top 5 most energy efficient days
select Date, avg(Energy_efficiency_score) as avg_score from power_consumption group by Date order by avg_score desc limit 5;

# Q26 Find anomaly records where power > 2× daily average
select p.* from power_consumption p 
join (select Date, avg(Global_active_power) as avg_power 
from power_consumption group by Date) d
on p.Date = d.Date where p.Global_active_power > 2 * d.avg_power;

# Q27 Rank days by total power usage
select Date, sum(Global_active_power) as total_power,
rank() over (order by sum(Global_active_power) desc) as power_rank from power_consumption group by Date;

# Q28 Detect voltage fluctuation (difference from previous reading)
select Date, Voltage, 
	Voltage - Lag(Voltage) over (order by Date) as voltage_change 
from power_consumption;

# Q29 Percentage contribution of each sub-metering
select 
	sum(Sub_metering_1) * 100 / sum(Total_sub_metering) as meter1_pc,
	sum(Sub_metering_2) * 100 / sum(Total_sub_metering) as meter2_pc,
    sum(Sub_metering_3) * 100 / sum(Total_sub_metering) as meter3_pc
from power_consumption;

# Q30 Classify consumption level
select Date, 
	case 
		when Global_active_power < 1 then 'Low'
        when Global_active_power between 1 and 3 then 'MEDIUM'
        else 'HIGH'
	end as consumption_category
from power_consumption;

select * from power_consumption;