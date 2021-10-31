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

