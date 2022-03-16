# Readme

Parsing the Lyme Conservation Easements as of 2-13-08.docx

1. Save as text
2. Break into lines:
	- Map and lot search - change to use two '••' at start of line
	- Change all single \n's to \t (puts each entry onto single line)
	
3. See how the columns line up




 Breaking up the Map & Lot:
 
 `^\t(\d\d\d)\t/\t([\.0-9]+)\t`	=> `••Map: \1\tLot-Unit:\2\t`