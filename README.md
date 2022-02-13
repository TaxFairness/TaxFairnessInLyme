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

- **002_Lyme Land Use Codes-17Nov2021.xlsx** Received a scanned PDF of Land use codes from assessing@lymenh.gov. This is an OCR'd version. Table is named **LymeUseCodes**

- **Assess\_Apprais\_Sales.xlsx** A view that's a combination of ScrapedData, the OldVsNew PDF file, and RecentSales tables, adding in the LandClass. Updated to include 2Dec2021 values for Appraised values. View is named **Assess\_Apprais\_Sales**

- **ASSESSED V. APPRAISED DINA W TTL LAND UNITS 21-1202-no-units.csv** Data from Todd via Dina that gives current (as of 2Dec2021) values for appraised & assessed values. Table is named **AsVsAPDina**

- **UniqueAsVsAPDina** A view that filters out duplicate rows of the AsVsAPDina table.

- **ConservationEasements** Imported data from B. Allison's table of easements up to 2008.

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

- **create\_database.sh** - a script to reliably create the tables & views of the SQLite database. Run this script to do all the work.

- **import\_into\_database.sh** - a script to import the various files into tables of the SQLite database

## SQL Statements for interesting queries

Paste the statements below into the "Exectute SQL" tab and click the 

**Are there assessments that differ between Town's PDF and scraped values from Vision?** _Short answer: Only a couple_

```sql
select 
	TA_Location, 
	TA_Map, 
	TA_Lot, 
	TA_Unit, 
	TA_Parcel_Value as Town_Assessment, 
	SD_Assessment2021 as Scraped_Assessment
from TownAssessment , ScrapedData 
on TA_Map = SD_Map and
	TA_Lot = SD_Lot and
	TA_Unit = SD_Unit and
	TA_Parcel_Value != SD_Assessment2021
;
```

**Are there MBLUs where Street Addresses don't match between Town_Assessment and Scraped_Data?** _Short answer: Some, nothing surprising. Mostly extra whitespace_

```sql
select 
	TA_Map, 
	TA_Lot, 
	TA_Unit, 
	TA_Location as TA_Location, 
	SD_Street_Address as Scraped_Location
from TownAssessment l 
join ScrapedData r
on TA_Map = r.SD_Map and
	TA_Lot = r.SD_Lot and
	TA_Unit = r.SD_Unit and
	trim(l.TA_Location) != trim(r.SD_Street_Address) AND
	SD_Street_Address not like "Problem%"
;
```

**What are the most common Land Use Codes used in Lyme?**

```sql
SELECT 
	count(SD_Description), 
	SD_Description
FROM ScrapedData
GROUP BY SD_Description
ORDER by count(*) DESC
;
```

**Compare UseCodes between VGSIinLyme, VisionOcc, and LymeUseCodes** _The answer: Substantial agreement, especially since the latter was truncated in the printout..._

```sql
SELECT 
	l.VL_Code, 
	r.VC_Code, 
	LC_UseCode,
	l.VL_Description as VGSIinLyme, 
	r.VC_Description as VisionOcc,
	LC_UseDescription as LymeUseCodes
FROM VGSIinLyme l, VISIONOccCodes r, LymeUseCodes c
ON l.VL_Code = r.VC_Code and
	VL_Code = LC_UseCode and
	(l.VL_Description != r.VC_Description OR
	 r.VC_Description != LC_UseDescription)
;
```

**Do MBLU's (and street addresses) from RecentSales match those from ScrapedData?** _The answer: Yes - differences are upper/lower case..._

```sql
SELECT 
	l.RS_Map, 
	l.RS_Lot, 
	l.RS_Unit, 
	l.RS_Address, 
	r.SD_Street_Address,
	l.RS_RecentSaleDate
from RecentSales l, ScrapedData r
on l.RS_Map = r.SD_Map and
	l.RS_Lot = r.SD_Lot and
	l.RS_Unit = r.SD_Unit and
	trim(l.RS_Address) != trim(r.SD_Street_Address) and
	trim(l.RS_Address) != ""
;
```

**Does RecentSales price differ much from Assessed value from ScrapedData?** _The answer: This query looks at 2020 dates to April 2021. A few wildly out of bounds_

```sql
SELECT 
	l.RS_Map as "Map", 
	l.RS_Lot as "Lot", 
	l.RS_Unit as "Unit", 
	l.RS_Address as "Address", 
	l.RS_RecentSaleDate as "Date",
	printf("$%,d",l.RS_RecentSalePrice) as RecentSalePrice, 
	printf("$%,d",r.SD_Assessment2021) as Assessment, 
	printf("%.0f",cast (100+100*(r.SD_Assessment2021-l.RS_RecentSalePrice)/l.RS_RecentSalePrice as real)) as "Percent"
from RecentSales l 
join ScrapedData r
on l.RS_Map = r.SD_Map and
	l.RS_Lot = r.SD_Lot and
	l.RS_Unit = r.SD_Unit
WHERE l.RS_Map != "" AND
	l.RS_RecentSaleDate < "2021-04-01"
ORDER BY cast(Percent as integer)
;
```

_Change the query above to use `l.RecentSaleDate >= "2021-04-01"` to get recent sales_

**Do Street Addresses from OldVsNew match those from ScrapedData?** _The answer: Yes - differences are upper/lower case..._

```sql
SELECT 
	r.ON_Page as "Page", 
	r.ON_Row as "Row", 
	"" as "",
	l.SD_Map as "Map", 
	l.SD_Lot as "Lot", 
	l.SD_Unit as "Unit", 
	l.SD_Street_Address as "Scraped Address", 
	r.ON_Location as "Old/New Address"
from ScrapedData l 
join OldVsNew r
on l.SD_Map = r.ON_Map and
	l.SD_Lot = r.ON_Lot and
	l.SD_Unit = r.ON_Unit and
	instr(l.SD_Street_Address,r.ON_Location) = 1;
;
```

**Do MBLU's from OldVsNew match those from ScrapedData?** _The answer: Yes - differences are upper/lower case..._

```sql
FAULTY SQL
```

**Look for duplicate entries in the UseCode column** _No interesting duplicates. Huzzah!_

```sql
select LC_UseCode, count(*) c 
from LymeUseCodes
group by LC_UseCode having c>1
;
```

**Select properties where Assessment < 50% of Appraisal** *173 properties, about
\$1.1M in tax savings*

```sql
select 
	SD_Street_Address as "Address", 
	printf("$%,d",SD_Assessment2021) as "2021 Assess.", 
	printf("$%,d",SD_Appraisal2021) as "2021 Apprais.", 
	printf("$%,d",SD_Appraisal2021-SD_Assessment2021) as "Difference",
	printf("%.0f",cast (100*(SD_Appraisal2021-SD_Assessment2021)/SD_Appraisal2021 as real)) as Ratio,
	printf("$%,d", cast (0.02407*(SD_Appraisal2021-SD_Assessment2021) as integer)) as "Tax Savings"
from ScrapedData
where 
	SD_Assessment2021 < SD_Appraisal2021*0.5 
order by cast(Ratio as integer) DESC
;
```

**Select Unique Rows between tables** _Performs a UNION, removing duplicates - 1068 rows; UNION ALL keeps duplicates. Ref: [https://www.sqlshack.com/compare-tables-sql-server/](https://www.sqlshack.com/compare-tables-sql-server/)_

```sql
select ON_Map, ON_Lot, ON_Unit from OldVsNew
UNION 
select SD_Map, SD_Lot, SD_Unit from ScrapedData
;
```

**Select Rows contained in both tables** _1045 rows_

```sql
select ON_Map, ON_Lot, ON_Unit from OldVsNew
INTERSECT 
select SD_Map, SD_Lot, SD_Unit from ScrapedData
;
```

**Select Rows in OldVsNew that aren't in ScrapedData** _20 rows_

This is now a VIEW in the database.
Each time either table is updated with an import, the contents
of this view should be explicable.

```sql
select ON_Map, ON_Lot, ON_Unit from OldVsNew
EXCEPT 
select SD_Map, SD_Lot, SD_Unit from ScrapedData
;
```
**And the reverse: Rows in ScrapedData that aren't in OldVsNew** 

This is now a VIEW in the database.
Each time either table is updated with an import, the contents
of this view should be explicable.

```sql
select SD_Map, SD_Lot, SD_Unit from ScrapedData
EXCEPT 
select ON_Map, ON_Lot, ON_Unit from OldVsNew
;
```

**Do the Old & New Assessments match between scanned PDF and Assessor's Excel spreadsheet?** _The answer: Yes - only #6 On The Common #1. differs, but it's a difference in the location (same values)_

```sql
SELECT 
	l.ON_Map, 
	l.ON_Lot, 
	l.ON_Unit, 
	l.ON_Location,
	l.ON_OldValue,
	l.ON_NewValue,
	r.LO_OldValue,
	r.LO_NewValue
from OldVsNew l, LymeOldToNew211202 r
on l.ON_Map = r.LO_Map and
	l.ON_Lot = r.LO_Lot and
	l.ON_Unit = r.LO_Unit and
	(LO_OldValue != ON_OldValue AND LO_NewValue != ON_NewValue)
;
```

**Which recently-improved properties have increased their assessments?** _Display 2020 Assessment plus cost of improvements, compare that "Computed Assessment" to the 2021 Assessment, with a "delta" showing above/below_

```sql
SELECT 
	l.ZP_Map, 
	l.ZP_Lot, 
	l.ZP_Unit, 
	l.ZP_Address, 
	l.ZP_DateIssued as "Date",
	l.ZP_Description,
	l.ZP_EstCost as "Est. Cost",
	r.SD_Prev_Assess2020,
	(r.SD_Prev_Assess2020+l.ZP_EstCost) as "Computed Assess.",
	r.SD_Assessment2021,
	(r.SD_Assessment2021-(r.SD_Prev_Assess2020+l.ZP_EstCost)) as "Delta"
from ZoningPermits l
LEFT JOIN ScrapedData r
on l.ZP_Map = r.SD_Map and
	l.ZP_Lot = r.SD_Lot and
	l.ZP_Unit = r.SD_Unit
WHERE l.ZP_DateIssued > "2020-01-01"
ORDER by ZP_DateIssued
;
```

**Properties whose Improvements, Land, or Total Assessment changed:** _Use where clause to select for Street Address; add `order by cast (SD_Street_Address as decimal)` to sort in the "natural order"._

```
select
	sd_map as "Map",
	sd_lot as "Lot",
	sd_unit as "Unit",
	SD_Street_Address as "Street Address",
	printf("$%,d", SD_App_Land2020) as "Land2020",
	printf("$%,d", SD_App_Land2021) as "Land2021",
	printf("%1.1f%", (sd_App_Land2021 *100.0/ sd_App_Land2020)-100) as "Land% incr",
	printf("$%,d", SD_App_Imp2020) as "Impr2020",
	printf("$%,d", SD_App_Imp2021) as "Impr2021",
	printf("%1.1f%", (sd_App_Imp2021 *100.0/SD_App_Imp2020)-100) as "Impr% incr",
	printf("$%,d", SD_App_Tot2020) as "Tot Appr. 2020",
	printf("$%,d", SD_App_Tot2021) as "Tot Appr. 2021",
	printf("%1.1f%", (sd_App_Tot2021 *100.0/ sd_App_Tot2020)-100) as "Total% incr",
	printf("$%,d", SD_Ass_Tot2020) as "Ass. 2020",
	printf("$%,d", SD_Assessment2021) as "Ass. 2021",
	printf("$%,d",cast (SD_Ass_Tot2020*26.66/1000 as integer)) as "Tax2020",
	printf("$%,d",cast (SD_Assessment2021*24.07/1000 as integer)) as "Tax2021",
	printf("%1.1f%",(SD_Assessment2021*24.07-SD_Ass_Tot2020*26.66)*100/(SD_Ass_Tot2020*26.66)) as "Tax %"
from ScrapedData2
where SD_Street_Address like "%river%"
order by (SD_Assessment2021*24.07-SD_Ass_Tot2020*26.66)*100/(SD_Ass_Tot2020*26.66) desc
-- order by cast(SD_Street_Address as decimal)
;
```

**Rows in Dina's spreadsheet not in the ScrapedData2** _WIP_

```sql
SELECT
SD_Street_Address, AA_Location,AA_Owner
from ScrapedData2
join AsVsApDina
on AA_Map = SD_Map AND
   AA_Lot = SD_Lot AND
   trim(AA_Unit) = trim(SD_Unit)
;
```