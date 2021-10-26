# Import data from the CSV files from various data sources
# This empties the databasetables, then imports the requisite files

delete from ScrapedData;
delete from TownAssessment;
.mode csv
.import Scraped-21Oct2021.csv ScrapedData
.import Town-Assessment-from-PDF-21Oct2021.csv TownAssessment
.import Vision-Occupancy-Codes.csv VisionOccCodes

.mode tabs
.import Land_Use_Codes_from_VGSI.txt VGSICodes