# About these files

This repo contains information about properties in Lyme retrieved from various sources:

- **Town Assessment-from PDF-12Oct2021.txt** This contains the Assessed value by owner - original source data comes from town website at: https://www.lymenh.gov/sites/g/files/vyhlif4636/f/uploads/assessed_value_by_owner_21-0909_0.pdf
It was massaged by PDF OCR X Enterprise Edition and a bunch of regexes to produce the Town Assessment-from PDF-12Oct2021.xlsx spreadsheet. Table (in the database) is named **TownAssessment**

- **Scraped-Data-19Oct2021.txt** Scraped Data, retrieved by the ScrapingVGSI script querying the Vision database. The current data is 19Oct2021.xlsx Table is named **ScrapedData**

- **Recent\_Sales\_Data\_from_Rusty-31Oct2021.csv** Values for recent sales (from April 2020 to date) collected from the Grafton County Register of Deeds. (Thanks, Rusty.) Table is named **Recentsales**

- **Vision Occupancy Codes.csv** Vision Occupancy Codes.xlsx - Excel file of four-digit code, description, "summary code", and guesses as to type of use. Table is named **VisionOccCodes**

- **Land\_Use\_Codes\_from\_VGSI.txt** Values of "land use codes" scraped from vgsi.com page - a two-column tab-delimited file that with four-digit codes plus telegraphic descriptions. Table is named **VGSIinLyme**

- **Lyme Zoning Permit 2016-2021.xlsx** Recent "building permits" from 2016 through April 2021. Table is named **ZoningPermits**

- **Old-NewValues2021.xlsx** Lyme gave a printout of old and new valuations to John Biglow who scanned it to produce Old-NewValues.pdf. Rich used [https://onlineocr.net](https://onlineocr.net) to convert it to a text file that could be imported into a spreadsheet. Table is named **OldVsNew**

## Why use a database?

The files here all get loaded into a SQLite database. (Don't worry - it's not scary.) Doing this has two major advantages:

1. It's easy to load the database _repeatably_ from the raw data files. In fact the `create_database.sh` file discussed below automatically pulls in all the files above into separate tables of a single database, so these can be combined and compared automatically. If we revise the raw data, we can simply re-import and then all the reports work exactly the same.

2. It's easy to re-run reports (again, _repeatably_). If we get new data, we can run the queries/reports and know that we're not skipping some important step.

F'rinstance... With Excel, it's a pain in the patootie to match up columns from different spreadsheets so the Map/Lot/Unit columns are the same. This is exactly what databases are designed to do: Show me columns A, B, and C from this spreadsheet and columns X, Y, and Z from the other spreadsheet where the Map/Lot/Unit are the same for both.

## Which Database?

I'm using [SQLite](https://sqlite.org/index.html) because it's small, fast, free, and runs on Macs and Windows (and Linux, too).  

I recommend [DB Browser for SQLite](https://sqlitebrowser.org/) as a database manager since it has a GUI to view the tables and run the SQL queries. It, too, is small, fast, free, and runs on Macs and Windows, and Linux.  

## Creating the database

- **Property-In-Lyme.sqlite** is the SQLite database. It has separate _tables_ for each of the five spreadsheets listed above. It gets created by the `create_database.sh` script below. It is usually pre-loaded with the latest data.

- **create\_database.sh** - a script to reliably create the tables & views of the SQLite databse

- **import\_into\_database.sh** - a script to import the various files into tables of the SQLite database

## SQL Statements for interesting queries

Paste the statements below into the "Exectute SQL" tab and click the 

**Are there assessments that differ between Town's PDF and scraped values from Vision?** _Short answer: Only a couple_

```sql
select l.Location, l.Map, l.Lot, l.Unit, l.Parcel_Value as Town_Assessment, r.Assessment as Scraped_Assessment
from TownAssessment l 
join ScrapedData r
on l.Map = r.Map and
	l.Lot = r.Lot and
	l.Unit = r.Unit and
	l.Parcel_Value != r.Assessment;
```

**Are there MBLUs where Street Addresses don't match between Town_Assessment and Scraped_Data?** _Short answer: Some, nothing surprising. Mostly extra whitespace_

```sql
select l.Map, l.Lot, l.Unit, l.Location as Town_Assessment_Location, r.Street_Address as Scraped_Location
from TownAssessment l 
join ScrapedData r
on l.Map = r.Map and
	l.Lot = r.Lot and
	l.Unit = r.Unit and
	trim(l.Location) != trim(r.Street_Address);
```

**What are the most common Land Use Codes used in Lyme?**

```sql
SELECT count(Description), Description
FROM ScrapedData
GROUP BY DESCRIPTION
ORDER by count(*) DESC;
```
**Do the Vision Occupancy codes match Lyme's VGSI codes?** _The answer: Mostly..._

```sql
SELECT l.Code, r.Code, l.Description as VGSIinLyme, r.Description as VisionOcc
FROM VGSIinLyme l
JOIN VISIONOccCodes r
ON l.Code = r.Code and
	l.Description != r.Description;
```

**Do MBLU's (and street addresses) from RecentSales match those from ScrapedData?** _The answer: Yes - differences are upper/lower case..._

```sql
SELECT l.Map, l.Lot, l.Unit, l.Address, r.Street_Address, l.RecentSaleDate
from RecentSales l 
join ScrapedData r
on l.Map = r.Map and
	l.Lot = r.Lot and
	l.Unit = r.Unit and
	trim(l.Address) != trim(r.Street_Address) and
	trim(l.Address) != "";
;
```

**Does RecentSales price differ much from Assessed value from ScrapedData?** _The answer: This query looks at 2020 dates to April 2021. A few wildly out of bounds_

```sql
SELECT l.Map, l.Lot, l.Unit, l.Address, l.RecentSaleDate,
	printf("%,d",l.RecentSalePrice) as RecentSalePrice, 
	printf("%,d",r.Assessment) as Assessment, 
	printf("%.0f",cast (100+100*(r.Assessment-l.RecentSalePrice)/l.RecentSalePrice as real)) as "Percent"
from RecentSales l 
join ScrapedData r
on l.Map = r.Map and
	l.Lot = r.Lot and
	l.Unit = r.Unit
WHERE l.Map != "" AND
	l.RecentSaleDate < "2021-04-01"
ORDER BY cast(Percent as integer)
;
```

_Change the query above to use `l.RecentSaleDate >= "2021-04-01"` to get recent sales_
