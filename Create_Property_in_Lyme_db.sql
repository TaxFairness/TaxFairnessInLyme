# Create the tables and views for the database

#INSERT INTO  "dates" (startDate,endDate) VALUES ('2014-01-01','2014-12-31');

CREATE TABLE "ScrapedData" (
"PID" TEXT,
"Street_Address" TEXT,
"MBLU" TEXT,
"Map" TEXT,
"Lot" TEXT,
"Unit" TEXT,
"Book_Page" TEXT,
"Assessment" REAL,
"Appraisal" REAL,
"Lot_Size" REAL,
"Land_Use_Code" TEXT,
"Description" TEXT,
"Zoning_District" TEXT,
"Num_Buildings" INTEGER,
"Appr_Year" TEXT,
"Improvements" REAL,
"Land_Value" REAL,
"Parcel_Value" REAL,
"Recent_Sale_Price" REAL,
"Recent_Sale_Date" TEXT,
"Prev_Sale_Price" REAL,
"Prev_Sale_Date" TEXT,
"Prev_Assess" REAL,
"Prev_Apprais" REAL,
"Empty1" TEXT,
"Empty2" TEXT
);

CREATE TABLE "TownAssessment"
(
"Owner Name" TEXT,
"Map" TEXT,
"Lot" TEXT,
"Unit" TEXT,
"Location" TEXT,
"Land_Value" REAL,
"Improvements" REAL,
"Parcel_Value" REAL,
"Empty" TEXT
);

CREATE TABLE "VGSICodes"
(
"Code" TEXT,
"Description" TEXT
);

CREATE TABLE "VISIONOccCodes"
(
"Code" TEXT,
"Description" TEXT,
"SummaryCode" TEXT,
"empty" TEXT,
"Type" TEXT
);

# select * from reservedOn r left join stayedOn s on r.resnum=s.resnum;

-- CREATE VIEW "summaryByCabin" as 
-- 	select 
-- 		resnum as ResNum, 
-- 		min(staydate) as StartDate, 
-- 		count(*) as Nights, 
-- 		max(staydate) as EndDate,
-- 		room as Cabin, 
-- 		stayguest as Guest, 
-- 		printf('$%.2f',sum(amount)) as Total
-- 	from 
-- 		reservations 
-- 	where 
-- 		staydate >= (select startDate from dates)
-- 		and 
-- 		staydate <= (select endDate from dates)
-- 	group by 
-- 		resnum, Room
-- 	order by
-- 		min(staydate)
-- 	;

-- CREATE VIEW "summaryByGuest" as
-- 	select 
-- 		resnum as ResNum, 
-- 		min(staydate) as StartDate, 
-- 		count(*) as Nights, 
-- 		max(staydate) as EndDate,
-- 		CASE
-- 			when count(distinct room) <= 5 then group_concat(DISTINCT room) 
-- 			else "Many"
-- 		end as 'Cabin(s)',
-- 		count(DISTINCT room) as '#Cabins',
-- 		stayguest as Guest, 
-- 		printf("$%.2f",sum(amount)) as Total
-- 	from 
-- 		reservations 
-- 	where 
-- 		staydate >= (select startDate from dates)
-- 		and 
-- 		staydate <= (select endDate from dates)	
-- 	group by 
-- 		stayguest
-- 	order by
-- 		min(staydate)
-- 	;
