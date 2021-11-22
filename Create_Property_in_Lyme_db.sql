# Create the tables and views for the database

#INSERT INTO  "dates" (startDate,endDate) VALUES ('2014-01-01','2014-12-31');

CREATE TABLE "ScrapedData" (
"SD_PID" TEXT,
"SD_Street_Address" TEXT,
"SD_MBLU" TEXT,
"SD_Map" TEXT,
"SD_Lot" TEXT,
"SD_Unit" TEXT,
"SD_Book_Page" TEXT,
"SD_Assessment2021" INTEGER,
"SD_Appraisal2021" INTEGER,
"SD_Lot_Size" INTEGER,
"SD_Land_Use_Code" TEXT,
"SD_Description" TEXT,
"SD_Zoning_District" TEXT,
"SD_Num_Buildings" INTEGER,
"SD_Appr_Year" TEXT,
"SD_Improvements2021" INTEGER,
"SD_Land_Value2021" INTEGER,
"SD_Parcel_Value2021" INTEGER,
"SD_Recent_Sale_Price" INTEGER,
"SD_Recent_Sale_Date" TEXT,
"SD_Prev_Sale_Price" INTEGER,
"SD_Prev_Sale_Date" TEXT,
"SD_Prev_Assess2020" INTEGER,
"SD_Prev_Apprais2020" INTEGER,
"SD_Empty1" TEXT,
"SD_Empty2" TEXT
);

CREATE TABLE "TownAssessment"
(
"TA_Owner Name" TEXT,
"TA_Map" TEXT,
"TA_Lot" TEXT,
"TA_Unit" TEXT,
"TA_Location" TEXT,
"TA_Land_Value" INTEGER,
"TA_Improvements" INTEGER,
"TA_Parcel_Value" INTEGER,
"TA_Empty" TEXT
);

CREATE TABLE "RecentSales" 
(
"RS_PID" TEXT,
"RS_Prev_Owner" TEXT,
"RS_Owner" TEXT, 
"RS_Address" TEXT,
"RS_MBLU" TEXT,
"RS_Map" TEXT,
"RS_Lot" TEXT,
"RS_Unit" TEXT,
"RS_Book-Page" TEXT,
"RS_RecentSalePrice" INTEGER,
"RS_RecentSaleDate" TEXT,
"RS_TransferTax" INTEGER,
"RS_BackCalc" TEXT
);

CREATE TABLE "VGSIinLyme"
(
"VL_Code" TEXT,
"VL_Description" TEXT
);

CREATE TABLE "VISIONOccCodes"
(
"VC_Code" TEXT,
"VC_Description" TEXT,
"VC_SummaryCode" TEXT,
"VC_empty" TEXT,
"VC_Type" TEXT
);

CREATE TABLE "ZoningPermits"
(
"ZP_PermitNumber" TEXT,
"ZP_DateApplication" TEXT,
"ZP_DateIssued" TEXT,
"ZP_Bogus1" TEXT,
"ZP_Map" TEXT,
"ZP_Map-Lot" TEXT,
"ZP_Lot" TEXT,
"ZP_Unit" TEXT,
"ZP_Address" TEXT,
"ZP_Applicant" TEXT,
"ZP_Description" TEXT,
"ZP_EstCost" INTEGER,
"ZP_Bogus2" TEXT,
"ZP_NewHousing" TEXT
);

CREATE TABLE "OldVsNew"
(
"ON_Page" TEXT,
"ON_Row" TEXT,
"ON_AcctNumber" TEXT,
"ON_Map" TEXT,
"ON_Lot" TEXT,
"ON_Unit" TEXT,
"ON_Location" TEXT,
"ON_Owner" TEXT,
"ON_UseCode" TEXT,
"ON_OldValue" INTEGER,
"ON_NewValue" INTEGER,
"ON_Ratio" REAL,
"ON_Difference" INTEGER
);

CREATE TABLE "LymeUseCodes"
(
"LC_Row" INTEGER,
"LC_UseCode" TEXT,
"LC_UseDescription" TEXT,
"LC_LandClass" TEXT,
"LC_LndLn1" TEXT,
"LC_LndLn2" TEXT,
"LC_Bldgs" TEXT,
"LC_Obldgs" TEXT
);

CREATE VIEW "Assess_Apprais_Sales" as 
select 
	SD_map as "Map", 
	SD_lot as "Lot", 
	SD_unit as "Unit", 
	SD_Street_Address as "Street Address",
	LC_LandClass as "Type",
	printf("$%,d",SD_Assessment2021) as "Assess. 2021",
	printf("$%,d",SD_Appraisal2021) as "Apprais. 2021",
	printf("$%,d",SD_Improvements2021) as "Improv. 2021",
	printf("$%,d",SD_Land_Value2021) as "Land Value 2021",
	printf("$%,d",SD_Parcel_Value2021) as "Total Value 2021",
	printf("$%,d",SD_Prev_Assess2020) as "Assess. 2020",
	printf("$%,d",SD_Prev_Apprais2020) as "Apprais. 2020",
	printf("$%,d",SD_Recent_Sale_Price) as "Recent Sale",
	SD_Recent_Sale_Date as "Recent Date",
	printf("$%,d",SD_Prev_Sale_Price) as "Previous Sale",
	SD_Prev_Sale_Date as "Previous Date"
from ScrapedData, LymeUseCodes
on
	SD_Land_Use_Code != ""
	AND  
	SD_Land_Use_Code = LC_UseCode
;

CREATE VIEW "Sanity_ScrapedNotInOldNew" as 
select ON_Map, ON_Lot, ON_Unit from OldVsNew
EXCEPT 
select SD_Map, SD_Lot, SD_Unit from ScrapedData
;

CREATE VIEW "Sanity_OldNewNotInScraped" as 
select SD_Map, SD_Lot, SD_Unit from ScrapedData
EXCEPT 
select ON_Map, ON_Lot, ON_Unit from OldVsNew
;
