/*

Purpose: Descriptive analysis of weight loss time series data

Date Started: December 25, 2019

*/

** Standard setup
* clear stata memory
clear all 
* load all output without pausing
set more off
* set directory (change this to your own directory where data is saved)
cd "/Users/hammadshaikh/Documents/GitHub/Weight-Food-Excercise-Data"

* Import new data set (time series)
use "WeightWaistFoodExcercise.dta", clear
* Time series data
tsset TimeUnitDay

* Detailed labels
label var WeightPounds "Weight (pounds) measured upon waking up"
label var Waistinches "Waist (inches) measured upon waking up - started collecting on aug 7"
label var PlatesFoodCons "Plates of food consumed at end of each day"
label var TimeUnitDay "Date (day, month, year) increments by day"

* Summary statistics
tabstat WeightPounds Waistinches BMI PlatesFoodCons Exerciseminutes, stats(mean median sd max range N)

* Look at weight and waist size over days
label var WeightPounds "Weight (pounds)"
label var Waistinches "Waist (inches)"
twoway (scatter WeightPounds TimeUnitDay, yaxis(1) msymbol(circle_hollow)) ///
(scatter Waistinches TimeUnitDay, yaxis(2) msymbol(circle_hollow)) if _n > 7 , xtitle("Dates (Day, Month, Year)", size(med)) ///
title("Hammad's Weight and Waist Size Over Time") graphregion(color(white))
graph export WeightWaistOverTime.pdf, replace

* Weight across months
label define MonthLabel 5 "May" 6 "June" 7 "July" 8 "Aug" 9 "Sept" 10 "Oct" 11 "Nov" 12 "Dec"
label values Month MonthLabel
graph bar (mean) WeightPounds, over(Month) title("Hammad's Mean Weight Across Months") ytitle("Weight (lbs)") graphregion(color(white)) blabel(bar, format(%4.1f) size(small)) bar(1,fcolor(ltblue))

