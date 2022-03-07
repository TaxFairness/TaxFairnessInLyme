# Import data from the CSV files from various data sources
# This empties the databasetables, then imports the requisite files

delete from ScrapedData;
delete from ScrapedData2;
delete from ScrapedData3;
delete from TownAssessment;
delete from VisionOccCodes;
delete from RecentSales;
delete from ZoningPermits;
delete from OldVsNew;
delete from LymeUseCodes;
delete from LymeOldToNew211202;
delete from ConservationEasements;
delete from SalesConsidered61;
delete from SalesNotUsed;

.mode csv
.import "DefinitiveData/ScrapedData-21Nov2021.csv" ScrapedData
.import "DefinitiveData/Town-Assessment-from-PDF-16Feb2022.csv" TownAssessment
.import "DefinitiveData/Vision-Occupancy-Codes.csv" VisionOccCodes
.import "DefinitiveData/Recent Sales Data from Rusty-31Oct2021.csv" RecentSales
.import "DefinitiveData/Lyme Zoning Permit 2016-2021.csv" ZoningPermits
.import "DefinitiveData/Old-NewValues2021-21Nov2021.csv" OldVsNew
.import "DefinitiveData/002_Lyme Land Use Codes-17Nov2021.csv" LymeUseCodes
.import "DefinitiveData/lyme old to new 21-1202-from-xls-cleaned.csv" LymeOldToNew211202
.import "DefinitiveData/ASSESSED V. APPRAISED DINA W TTL LAND UNITS 21-1202-no-units.csv" RawAsVsAPDina
.import "DefinitiveData/Lyme Conservation Easements as of 2-13-08.csv" ConservationEasements
.import "DefinitiveData/ScrapedData12Jan2022.csv" ScrapedData2
.import "DefinitiveData/ScrapedData6Mar2022.csv" ScrapedData3
.import "DefinitiveData/all sales 19-0401-21-0930 16-tab.csv" SalesConsidered61
.import "DefinitiveData/Sales Not Used-12Jan2022.csv" SalesNotUsed

delete from VGSIinLyme;
.mode tabs
.import "DefinitiveData/Land_Use_Codes_from_VGSI.txt" VGSIinLyme
