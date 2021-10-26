# About these files

This repo contains information about properties in Lyme retrieved from various sources:

- Assessed value by owner - original source data comes from town website at: https://www.lymenh.gov/sites/g/files/vyhlif4636/f/uploads/assessed_value_by_owner_21-0909_0.pdf
It was massaged by PDF OCR X Enterprise Edition and a bunch of regexes to produce the Town Assessment-from PDF-12Oct2021.xlsx spreadsheet; the tab-delimited equivalent is Town Assessment-from PDF-12Oct2021.txt

- Scraped Data, retrieved by the ScrapingVGSI script querying the Vision database. The current data is 19Oct2021.xlsx, and the tab-delimited file is Scraped-Data-19Oct2021.txt

- Grafton County Register of Deeds information on recent sales (from April 2020 to date)

- Vision Occupancy Codes.xlsx - Excel file of four-digit code, description, "summary code", and guesses as to type of use. This is exported to Vision Occupancy Codes.csv 

- Land_Use_Codes_from_VGSI.txt - Scraped from vgsi.com page - a two-column tab-delimited file that with four-digit codes plus telegraphic descriptions

These files are read into tables of a SQLite database for processing. The associated files are:

- Property-in-Lyme.sqlite - the SQLite database that has the tables, one for each of the input files

- create_database.sh - reliably create the tables & views of the SQLite databse

- import_into_database.sh - Import the various files into tables of the SQLite database


## SQL Statements for retrieving interesting database

Select & Join: https://stackoverflow.com/questions/17434929/joining-two-tables-with-specific-columns

**Find assessments that are different between Town's PDF and scraped values from Vision**

select l.Location, l.Map, l.Lot, l.Unit, l.Parcel_Value as Town_Assessment, r.Assessment as Scraped_Assessment
from TownAssessment l 
join ScrapedData r
on l.Map = r.Map and
	l.Lot = r.Lot and
	l.Unit = r.Unit and
	l.Parcel_Value != r.Appraisal;

**Find MBLUs where Street Addresses don't match between Town_Assessment and Scraped_Data**

select l.Map, l.Lot, l.Unit, l.Location as Town_Assessment_Location, r.Street_Address as Scraped_Location
from TownAssessment l 
join ScrapedData r
on l.Map = r.Map and
	l.Lot = r.Lot and
	l.Unit = r.Unit and
	trim(l.Location) != trim(r.Street_Address);