# Create the tables and views for the database

#INSERT INTO  "dates" (startDate,endDate) VALUES ('2014-01-01','2014-12-31');

CREATE TABLE "ScrapedData" (
"SD_PID" TEXT,
"SD_Street_Address" TEXT,
"SD_MBLU" TEXT,
"SD_Map" INTEGER,
"SD_Lot" INTEGER,
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

CREATE TABLE "ScrapedData2" (
"SD_PID" TEXT,
"SD_Street_Address" TEXT,
"SD_MBLU" TEXT,
"SD_Map" INTEGER,
"SD_Lot" INTEGER,
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
"SD_App_Imp2021" INTEGER,
"SD_App_Land2021" INTEGER,
"SD_App_Tot2021" INTEGER,
"SD_Recent_Sale_Price" INTEGER,
"SD_Recent_Sale_Date" TEXT,
"SD_Prev_Sale_Price" INTEGER,
"SD_Prev_Sale_Date" TEXT,
"SD_Ass_Imp2020" INTEGER,
"SD_Ass_Land2020" INTEGER,
"SD_Ass_Tot2020" INTEGER,
"SD_App_Imp2020" INTEGER,
"SD_App_Land2020" INTEGER,
"SD_App_Tot2020" INTEGER,
"SD_Empty1" TEXT,
"SD_Empty2" TEXT
);


CREATE TABLE "TownAssessment"
(
"TA_Owner Name" TEXT,
"TA_Map" INTEGER,
"TA_Lot" INTEGER,
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
"RS_Map" INTEGER,
"RS_Lot" INTEGER,
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
"ZP_Map" INTEGER,
"ZP_Lot_Unit" TEXT,
"ZP_Lot" INTEGER,
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
"ON_Map" INTEGER,
"ON_Lot" INTEGER,
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

CREATE TABLE "LymeOldToNew211202"
(
"LO_AcctNumber" TEXT,
"LO_Map" INTEGER,
"LO_Lot" INTEGER,
"LO_Unit" TEXT,
"LO_Empty1" TEXT,
"LO_Location" TEXT,
"LO_Owner" TEXT,
"LO_UseCode" TEXT,
"LO_OldValue" INTEGER,
"LO_NewValue" INTEGER,
"LO_Ratio" REAL,
"LO_Difference" INTEGER
);

CREATE TABLE "AsVsApDina"
(
"AA_Map" INTEGER,
"AA_Lot" INTEGER,
"AA_Unit" TEXT,
"AA_Empty1" TEXT,
"AA_Location" TEXT,
"AA_Owner" TEXT,
"AA_Appraisal_Improvements" INTEGER,
"AA_Assessment_Improvements" INTEGER,
"AA_Appraisal_Land" INTEGER,
"AA_Assessment_Land" INTEGER,
"AA_Appraisal_Total" INTEGER,
"AA_Assessment_Total" INTEGER,
"AA_UseCode" TEXT,
"AA_UseDescr" TEXT,
"AA_Units" TEXT,
"AA_Mailing" TEXT,
"AA_City" TEXT,
"AA_State" TEXT,
"AA_Zip" TEXT
);

CREATE TABLE "ConservationEasements"
(
"CE_Map" INTEGER,
"CE_Lot-Unit" TEXT,
"CE_Lot" INTEGER,
"CE_Unit" TEXT,
"CE_Owner" TEXT,
"CE_OwnerAddress" TEXT,
"CE_Town_State_Zip" TEXT,
"CE_Phone" TEXT,
"CE_NHLCIP" TEXT,
"CE_Book" TEXT,
"CE_Page" TEXT,
"CE_Acres" REAL, 
"CE_Date" TEXT,
"CE_Grantor" TEXT,
"CE_Holder1" TEXT,
"CE_Holder2" TEXT,
"CE_Monitor" TEXT,
"CE_Location" TEXT, 
"CE_Description1" TEXT,
"CE_Description2" TEXT,
"CE_Description3" TEXT,
"CE_Description4" TEXT
)
;

# Current Appraisal values (from Todd's latest spreadsheet via Dina) plus scraped values
CREATE VIEW "Assess_Apprais_Sales" as 
select 
	SD_map as "Map", 
	SD_lot as "Lot", 
	SD_unit as "Unit", 
	SD_Street_Address as "Street Address",
	SD_Lot_Size as "Acres",
	LC_LandClass as "Class",
	printf("$%,d",SD_Assessment2021) as "Assess. 2021",
	printf("$%,d",AA_Appraisal_Total) as "Apprais. 2021",
	printf("$%,d",AA_Appraisal_Improvements) as "Improv. 2021",
	printf("$%,d",AA_Appraisal_Land) as "Land Value 2021",
	printf("$%,d",SD_Prev_Assess2020) as "Assess. 2020",
	printf("$%,d",SD_Prev_Apprais2020) as "Apprais. 2020",
	printf("$%,d",SD_Recent_Sale_Price) as "Recent Sale",
	SD_Recent_Sale_Date as "Recent Date",
	printf("$%,d",SD_Prev_Sale_Price) as "Previous Sale",
	SD_Prev_Sale_Date as "Previous Date",
	printf("$%,d",RS_RecentSalePrice) as "Grafton Sale",
	RS_RecentSaleDate as "Grafton Date"

FROM ScrapedData
LEFT JOIN RecentSales on
	SD_Map = RS_Map
	AND SD_Lot = RS_Lot
	and SD_Unit = RS_Unit
LEFT JOIN UniqueAssessVsApprais on
	SD_Map = AA_Map 
	AND SD_Lot = AA_Lot
	AND SD_Unit = AA_Unit
LEFT JOIN LymeUseCodes
ON 
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

CREATE VIEW "UniqueAssessVsApprais" as 
select distinct 
	"AA_Map" ,
	"AA_Lot",
	"AA_Unit",
	"AA_Location" 
	"AA_Owner",
	"AA_Appraisal_Improvements" ,
	"AA_Assessment_Improvements" ,
	"AA_Appraisal_Land" ,
	"AA_Assessment_Land" ,
	"AA_Appraisal_Total" ,
	"AA_Assessment_Total" 
from AsVsAPDina;
