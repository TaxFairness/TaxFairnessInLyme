# Import data from the CSV files from various data sources
# This empties the databasetables, then imports the requisite files

delete from ScrapedData;
delete from TownAssessment;
delete from VisionOccCodes;
delete from RecentSales;
delete from ZoningPermits;
delete from OldVsNew;
delete from LymeUseCodes;

.mode csv
.import Scraped-21Oct2021.csv ScrapedData
.import Town-Assessment-from-PDF-21Oct2021.csv TownAssessment
.import Vision-Occupancy-Codes.csv VisionOccCodes
.import "Recent Sales Data from Rusty-31Oct2021.csv" RecentSales
.import "Lyme Zoning Permit 2016-2021.csv" ZoningPermits
.import "Old-New Values/Old-NewValues2021-16Nov2021.csv" OldVsNew
.import "002_Lyme Land Use Codes-17Nov2021.csv" LymeUseCodes

delete from VGSIinLyme;
.mode tabs
.import Land_Use_Codes_from_VGSI.txt VGSIinLyme
