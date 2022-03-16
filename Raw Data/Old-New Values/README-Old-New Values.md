# Old-New Values 

The Excel spreadsheet _Old-NewValues2021.xlsx_ contains the massaged data that came from the scanned (paper) report from the Town Office. That scanned PDF (Old-New Values2021.pdf) was run through [https://onlineocr.net](https://onlineocr.net) to produce a text file of the data. (I had to register to scan a multi-page document, but it did a fairly good job of noticing that there were a bunch of values on a single line. (Other OCR programs did a remarkably poor job of detecting this...))

I then used some regular expressions to coalesce the columns, and detect scanning errors.

To detect the fields at the start of a line:

`^([\dT]+)[ ]+(\d+)[ ]+([\d]+)[ ]+([\dETP]*)[ ]{6,}`

To detect the fields at the end of a line: 

`(\d\d\d[A-Z\d])[ ]+([,\d]+)[ ]+([,\d]+)[ ]+(-*\d\.\d\d)[ ]+([-\d,]+)`

I substituted a bullet character ("•") between the match groups, with the goal to replace the "•" with a tab. There is also a lot of fussy hand work to clean up the data.

Finally, substitute those • characters with a tab to make a file to read into a spreadsheet.

This allows me to check and correct column alignment. 

## Folder contents:

001_Old-NewValues2021(orig from onlineocr.net).txt - the original file from the conversion site.

001_Old-NewValues2021-corrected.txt - the next step in cleaning up the file

...

001_Old-NewValues2021-corrected-5.txt - the final step in cleaning up the file

