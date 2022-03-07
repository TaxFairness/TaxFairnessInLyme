# About these files

This repository contains information about properties in Lyme retrieved from various sources.
It contains:

1. A SQLite database (named **Property\_In\_Lyme.sqlite**) with a variety of data files, imported from...

2. The **DefinitiveData** folder.
This contains all the highly-massaged output files
that get read into the SQLite database.
The import process gets data from the following files:

   - **all sales 19-0401-21-0930 16-tab.csv**
This lists all (61) sales considered by the Assessor for the 2021 revaluation.
Table is named **SalesConsidered61**

   - **ASSESSED V. APPRAISED DINA W TTL LAND UNITS 21-1202-no-units.csv**
Data from Assessor via Dina that gives current (as of 2Dec2021) values for
appraised & assessed values.
Table is named **AsVsAPDina**

   - **Land\_Use\_Codes\_from\_VGSI.txt**
Values of "land use codes" scraped from vgsi.com page -
a two-column tab-delimited file that with four-digit codes plus telegraphic descriptions.
Table is named **VGSIinLyme**

   - **Lyme Conservation Easements as of 2-13-08.csv**
Imported data from B. Allison's table of easements up to 2008.
Table is named **ConservationEasements**

   - **lyme old to new 21-1202-from-xls-cleaned.csv**
From original Assessor file named _lyme old to new 21-1202.xls_ in a tricky format.
Exported as text, then cleaned to create this file.
Table is named **LymeOldToNew211202**

   - **Lyme Zoning Permit 2016-2021.csv**
Recent "building permits" from 2016 through April 2021.
Table is named **ZoningPermits**

   - **Old-NewValues2021-21Nov2021.csv**
Lyme gave a printout of old and new valuations to John Biglow who scanned
it to produce Old-NewValues.pdf.
Rich used [https://onlineocr.net](https://onlineocr.net) to convert it to a
text file that could be imported into a spreadsheet. Source data is in _Old-New Values_ folder.
Table is named **OldVsNew**

   - **Recent\_Sales\_Data\_from_Rusty-31Oct2021.csv**
Values for recent sales (from April 2020 to date) collected from the Grafton County
Register of Deeds collected by R. Keith.
Table is named **Recentsales**

   - **Sales Not Used-12Jan2022.csv**
Approximately 80 properties manually entered and checked by R & L Brown
from photos of the pages from the Assessor Manual by H Quinton.
This includes properties known not to be arms-length as well as a
number that likely _are_ arms-length.
There's no distinction between the two in this table.
Table is named **SalesNotUsed**

   - **ScrapedData-21Nov2022.csv**
Scraped Data, retrieved by the ScrapingVGSI script querying the Vision database.
Scrape date is 21 Nov 2021.
Table is named **ScrapedData**

   - **ScrapedData12Jan2022.csv**
Re-scrape of the VGSI site on 12 Jan 2022, retrieving current (post-revaluation)
data and new columns, such as _current_ land/improv/total and _previous_
land/improv/total assessments and appraisals.
Table is named **ScrapedData2**

   - **ScrapedData6Mar2022.csv**
Re-scrape of the VGSI site on 24 Feb 2022, retrieving additional columns such as
owner name and current/prior values for both appraised & assessed
Land/Improvements/Total values (a total of 2 x 2 x 3 columns).
Updated 6Mar2022 to ensure that all empty Unit values are "".
Table is named **ScrapedData3**

   - **Town-Assessment-from-PDF-16Feb2022.csv**
This contains the Assessed value by owner.
Original source data comes from town website on 21Oct2021 at:
https://www.lymenh.gov/sites/g/files/vyhlif4636/f/uploads/assessed\_value\_by\_owner\_21-0909_0.pdf
It was massaged by PDF OCR X Enterprise Edition and a bunch of regexes to produce
the Town Assessment-from PDF-12Oct2021.xlsx spreadsheet.
Data cleaned up in separate pass on 16Feb2022.
Table is named **TownAssessment**

   - **Vision Occupancy Codes.csv**
Vision Occupancy Codes.xlsx - Excel file of four-digit code, description,
"summary code", and guesses as to type of use.
Table is named **VisionOccCodes**

   - **002_Lyme Land Use Codes-17Nov2021.csv**
Received a scanned PDF of Land use codes from assessing@lymenh.gov.
This is an OCR'd version.
Table is named **LymeUseCodes**

3. Assorted "raw data" files that hav been processed to produce 
the files in the **DefinitiveData** folder

## Why use a database?

The files here all get loaded into a SQLite database.
(Don't worry - it's not scary.)
Doing this has two major advantages:

1. It's easy to load the database _repeatably_ from the raw data files.
In fact the `create_database.sh` file discussed below automatically pulls
in all the files above into separate tables of a single database,
so these can be combined and compared automatically.
If we revise the raw data, we can simply re-import and
then all the reports work exactly the same.

2. It's easy to re-run reports (again, _repeatably_).
If we get new data, we can run the queries/reports and know
that we're not skipping some important step.

F'rinstance... With Excel, it's a pain in the patootie to match up columns
from different spreadsheets so the Map/Lot/Unit columns are the same.
This is exactly what databases are designed to do:
_Show me columns A, B, and C from this file and columns X, Y, and Z
from the other file where the Map/Lot/Unit are the same for both._

## Which Database?

I used [SQLite](https://sqlite.org/index.html) because it's small, fast, free,
and runs on Macs and Windows (and Linux, too).  

I recommend [DB Browser for SQLite](https://sqlitebrowser.org/)
as a database manager since it has a GUI to view the tables
and run the SQL queries.
It, too, is small, fast, free, and runs on Macs and Windows, and Linux.  

## Creating the database

Run `sh create_database.sh` to delete all the tables/information from the 
SQLite database called **Property-in-Lyme.sqlite**,
then import all the files from the **DefinitiveData** folder.
The resulting database
has separate _tables_, one for each of the imported files.

This script can be run as many times as necessary -
it completely re-generates the database file.
This becomes handy if we discover errors in the **DefinitiveData** folder.
Simply correct the `.csv` file there, and re-run the import script.

The import process uses these files:

- **create\_database.sh** - a script to reliably create the tables & views of the SQLite database.
Run this script with `sh create_database.sh` - it does all the work.

- **Create\_Property\_in\_Lyme.db.sql** - a series of SQL statements
to create a new (empty) database with each of the tables setup up (but empty).

- **import\_into\_database.sh** - a helper script to import the
various files into tables of the SQLite database

## Using the Database

You can Google for tutorials about _DB Browser for SQLite_.
Here are some tips for getting started:

- Click _Open Database_ and select **Property\_In\_Lyme.sqlite** to open the database
- The _Database Structure_ tab simply lists the various tables available.
Not terribly interesting.
- The _Edit Pragmas_ tab lets you optimize the database performance.
This is a small database, and thus really fast. Not terribly interesting.
- The _Browse Data_ tab _is_ interesting.
Choose from the _Table_ dropdown (upper left) to see the contents of each table.
You'll recognize all the columns from the spreadsheets.
Click a column heading to sort by that column.
Enter a value in _Filter_ at the top of a colum to select matching rows.
- In general, when you quit/exit from the database program you should not save any changes.
This would be important if our work needed to change the data within the tables.
But we're not using the database that way:
we're just "making queries" on the data to see the relationships.
(If we do need to correct underlying data, we should update the file in
the "Definitive Data" folder and re-import.)
- Finally, the _Execute SQL_ tab is where we have all the fun.
Enter SQL commands in the top half.
(These _SQL statements_ are commands to combine certain columns
from various tables and exclude certain rows to produce another table.)
The bottom half shows the result after "running the query".

The remainder of this document has SQL queries to copy/paste.

## SQL Statements for Interesting Queries

Paste any of the statements below into the "Exectute SQL" tab and
click the Run button (Cmd-R/Ctl-R) to execute it.

**Properties whose Improvements, Land, or Total Assessment changed:**
_Uncomment the `where...` clause to select for Street Address;
Uncomment one of the `order by...` clauses to change the sort order._

```sql
select
	sd_map as "Map",
	sd_lot as "Lot",
	sd_unit as "Unit",
	SD_Street_Address as "Street Address",
	SD_Owner as "Owner",
	SD_Lot_Size as "Acres",
	printf("$%,d", SD_App_Land2020) as "AppLand2020",
	printf("$%,d", SD_App_Land2021) as "AppLand2021",
	printf("%1.1f%", (sd_App_Land2021 *100.0/ sd_App_Land2020)-100) as "AppLand% incr",
	printf("$%,d", SD_App_Imp2020) as "AppImpr2020",
	printf("$%,d", SD_App_Imp2021) as "AppImpr2021",
	printf("%1.1f%", (sd_App_Imp2021 *100.0/SD_App_Imp2020)-100) as "AppImpr% incr",
	printf("$%,d", SD_App_Tot2020) as "Tot Appr. 2020",
	printf("$%,d", SD_App_Tot2021) as "Tot Appr. 2021",
	printf("%1.1f%", (sd_App_Tot2021 *100.0/ sd_App_Tot2020)-100) as "Total Appr% incr",
	printf("$%,d", SD_Ass_Land2020) as "AssLand2020",
	printf("$%,d", SD_Ass_Land2021) as "AssLand2021",
	printf("%1.1f%", (sd_Ass_Land2021 *100.0/ sd_Ass_Land2020)-100) as "AssLand% incr",
	printf("$%,d", SD_Ass_Imp2020) as "AssImpr2020",
	printf("$%,d", SD_Ass_Imp2021) as "AssImpr2021",
	printf("%1.1f%", (sd_Ass_Imp2021 *100.0/SD_Ass_Imp2020)-100) as "AssImpr% incr",
	printf("$%,d", SD_Ass_Tot2020) as "Tot Ass. 2020",
	printf("$%,d", SD_Ass_Tot2021) as "Tot Ass. 2021",
	printf("%1.1f%", (sd_Ass_Tot2021 *100.0/ sd_Ass_Tot2020)-100) as "Total Ass.% incr",
	printf("$%,d", SD_Ass_Tot2020) as "Ass. 2020",
	printf("$%,d", SD_Assessment2021) as "Ass. 2021",
	printf("$%,d",cast (SD_Ass_Tot2020*26.66/1000 as integer)) as "Tax2020",
	printf("$%,d",cast (SD_Assessment2021*24.07/1000 as integer)) as "Tax2021",
	printf("%1.1f%",(SD_Assessment2021*24.07-SD_Ass_Tot2020*26.66)*100/(SD_Ass_Tot2020*26.66)) as "Tax %"
from ScrapedData3

where SD_Street_Address like "%orford %"

--order by (SD_Assessment2021*24.07-SD_Ass_Tot2020*26.66)*100/(SD_Ass_Tot2020*26.66) desc -- Tax Increase
order by cast(SD_Street_Address as decimal) -- Street Address
-- order by ((sd_App_Tot2021 *100.0/ sd_App_Tot2020)-100) -- Total Appraisal increase
-- order by ((sd_App_Land2021 *100.0/ sd_App_Land2020)-100) -- Increased Land Value
;
```

**Properties that seem under-appraised**
_Select all (61) recent sale values and compare to the 2021 total appraised value_

```
SELECT
	r.SD_PID,
	l.SC_Map, l.SC_Lot, L.SC_Unit,
	l.SC_Location,
	l.SC_SalePrice,
	r.SD_App_Tot2021,
	printf("%,d",(r.SD_App_Tot2021 - l.SC_SalePrice)) as "Underappraisal",
	printf("%1.1f%",(r.SD_App_Tot2021 - l.SC_SalePrice)*100/r.SD_App_Tot2021) as "Percent"
from SalesConsidered61 l
left JOIN ScrapedData3 r

on SC_Map = SD_Map AND SC_Lot = SD_Lot AND SC_Unit = SD_Unit

--where r.SD_App_Tot2021 <> NULL
order by r.SD_App_Tot2021 DESC
;
```

**Are there assessments that differ between Town's PDF and scraped values from Vision?**
_Short answer: Only a couple_

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

**Are there MBLUs where Street Addresses don't match between Town_Assessment and Scraped_Data?**
_Short answer: Some, nothing surprising. Mostly extra whitespace_

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

**Compare UseCodes between VGSIinLyme, VisionOcc, and LymeUseCodes**
_The answer: Substantial agreement, especially since the latter was
truncated in the printout..._

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

**Do MBLU's (and street addresses) from RecentSales match those from ScrapedData?**
_The answer: Yes - differences are upper/lower case..._

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

**Does RecentSales price differ much from Assessed value from ScrapedData?**
_The answer: This query looks at 2020 dates to April 2021.
A few wildly out of bounds_

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

_Change the query above to use `l.RecentSaleDate >= "2021-04-01"`
to get recent sales_

**Do Street Addresses from OldVsNew match those from ScrapedData?**
_The answer: Yes - differences are upper/lower case..._

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

**Do MBLU's from OldVsNew match those from ScrapedData?**
_The answer: Yes - differences are upper/lower case..._

```sql
FAULTY SQL
```

**Look for duplicate entries in the UseCode column**
_No interesting duplicates. Huzzah!_

```sql
select LC_UseCode, count(*) c 
from LymeUseCodes
group by LC_UseCode having c>1
;
```

**Select properties where Assessment < 50% of Appraisal**
*173 properties, about \$1.1M in tax savings*

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

**Select Unique Rows between tables**
_Performs a UNION, removing duplicates - 1068 rows; UNION ALL keeps duplicates.
Ref: [https://www.sqlshack.com/compare-tables-sql-server/](https://www.sqlshack.com/compare-tables-sql-server/)_

```sql
select ON_Map, ON_Lot, ON_Unit from OldVsNew
UNION 
select SD_Map, SD_Lot, SD_Unit from ScrapedData
;
```

**Select Rows contained in both tables**
_1045 rows_

```sql
select ON_Map, ON_Lot, ON_Unit from OldVsNew
INTERSECT 
select SD_Map, SD_Lot, SD_Unit from ScrapedData
;
```

**Select Rows in OldVsNew that aren't in ScrapedData**
_20 rows_

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

**Do the Old & New Assessments match between scanned PDF and Assessor's Excel spreadsheet?**
_The answer: Yes - only #6 On The Common #1. differs, but it's a
difference in the location (same values)_

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

**Which recently-improved properties have increased their assessments?**
_Display 2020 Assessment plus cost of improvements, compare that
"Computed Assessment" to the 2021 Assessment, with a "delta" showing above/below_

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

**Horsing around with joins...***

```sql
-- horsing around with joins
select 
	AA_Map,
	AA_Lot,
	AA_Unit,
	AA_Owner,
	SD_Map,
	SD_Lot,
	SD_Unit,
	SD_Owner
from AsVsApDina --, scrapeddata3
inner join ScrapedData3
on aa_map = SD_map and AA_Lot = SD_lot AND AA_Unit = SD_Unit
;
```

### Views in the Database

The _Database Structure_ tab shows both tables (above) and _Views_ that are
automatically constructed from the data from various tables...

- **Assess\_Apprais\_Sales**
A view that's a combination of ScrapedData, the OldVsNew PDF file,
and RecentSales tables, adding in the LandClass.
Updated to include 2Dec2021 values for Appraised values.
Superceded by the first SQL statement (above). 

- **UniqueAsVsAPDina** A view that filters out duplicate rows
of the AsVsAPDina table. 
