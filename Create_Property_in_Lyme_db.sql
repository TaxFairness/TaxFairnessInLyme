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
"Assessment" INTEGER,
"Appraisal" INTEGER,
"Lot_Size" INTEGER,
"Land_Use_Code" TEXT,
"Description" TEXT,
"Zoning_District" TEXT,
"Num_Buildings" INTEGER,
"Appr_Year" TEXT,
"Improvements" INTEGER,
"Land_Value" INTEGER,
"Parcel_Value" INTEGER,
"Recent_Sale_Price" INTEGER,
"Recent_Sale_Date" TEXT,
"Prev_Sale_Price" INTEGER,
"Prev_Sale_Date" TEXT,
"Prev_Assess" INTEGER,
"Prev_Apprais" INTEGER,
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
"Land_Value" INTEGER,
"Improvements" INTEGER,
"Parcel_Value" INTEGER,
"Empty" TEXT
);

CREATE TABLE "RecentSales" 
(
"PID" TEXT,
"Prev_Owner" TEXT,
"Owner" TEXT, 
"Address" TEXT,
"MBLU" TEXT,
"Map" TEXT,
"Lot" TEXT,
"Unit" TEXT,
"Book-Page" TEXT,
"RecentSalePrice" INTEGER,
"RecentSaleDate" TEXT,
"TransferTax" INTEGER,
"BackCalc" TEXT
);

CREATE TABLE "VGSIinLyme"
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

CREATE TABLE "ZoningPermits"
(
"PermitNumber" TEXT,
"DateApplication" TEXT,
"DateIssued" TEXT,
"Bogus1" TEXT,
"Map" TEXT,
"Map-Lot" TEXT,
"Lot" TEXT,
"Unit" TEXT,
"Address" TEXT,
"Applicant" TEXT,
"Description" TEXT,
"EstCost" INTEGER,
"Bogus2" TEXT,
"NewHousing" TEXT
);

CREATE TABLE "OldVsNew"
(
"Page" TEXT,
"Row" TEXT,
"AcctNumber" TEXT,
"Map" TEXT,
"Lot" TEXT,
"Unit" TEXT,
"Location" TEXT,
"Owner" TEXT,
"UseCode" TEXT,
"OldValue" INTEGER,
"NewValue" INTEGER,
"Ratio" REAL,
"Difference" INTEGER
);
