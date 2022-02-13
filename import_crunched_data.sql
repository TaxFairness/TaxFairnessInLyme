# Import data from the CSV files from various data sources
# This empties the databasetables, then imports the requisite files

delete from ScrapedData;
delete from ScrapedData2;
delete from TownAssessment;
delete from VisionOccCodes;
delete from RecentSales;
delete from ZoningPermits;
delete from OldVsNew;
delete from LymeUseCodes;
delete from LymeOldToNew211202;
delete from ConservationEasements;

.mode csv
.import ScrapedData-21Nov2021.csv ScrapedData
.import Town-Assessment-from-PDF-21Oct2021.csv TownAssessment
.import Vision-Occupancy-Codes.csv VisionOccCodes
.import "Recent Sales Data from Rusty-31Oct2021.csv" RecentSales
.import "Lyme Zoning Permit 2016-2021.csv" ZoningPermits
.import "Old-New Values/Old-NewValues2021-21Nov2021.csv" OldVsNew
.import "002_Lyme Land Use Codes-17Nov2021.csv" LymeUseCodes
.import "Todd Data-3Dec2021/lyme old to new 21-1202-from-xls-cleaned.csv" LymeOldToNew211202
.import "Todd Data-3Dec2021/ASSESSED V. APPRAISED DINA W TTL LAND UNITS 21-1202-no-units.csv" AsVsAPDina
.import "Conservation Easements/Lyme Conservation Easements as of 2-13-08.csv" ConservationEasements
.import ScrapedData12Jan2022.csv ScrapedData2

delete from VGSIinLyme;
.mode tabs
.import Land_Use_Codes_from_VGSI.txt VGSIinLyme
