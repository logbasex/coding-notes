## LibreOffice command

<pre>
    # open csv file with LibreOffice Calc.
    libreoffice --calc data.csv    
    
    # convert .xls file to csv using LibreOffice headless mode.
    libreoffice --headless --convert-to csv "Horse Branding.xls" 
    
    # convert all .xls files in specific folder to .csv files
    for i   in *.xlsx; do  libreoffice --headless --convert-to csv "$i" ; done
</pre>

- Advanced filter
    - https://www.ahuka.com/libreoffice-3-5-tutorials/libreoffice-calc/libreoffice-calc-data-manipulation-2-standard-filters/
    - youtube.com/watch?v=r8pK4B_aJl8


- Convert hyperlink to text: https://gist.github.com/ibarraespinosa/bb26845563c0afff069de4434d60db29