## Split file into pieces by line number
```shell
split -l 200 -d data.csv
```
output
```shell
ll 

-rw-rw-r-- 1 logbasex logbasex 8,5K Thg 5  16 10:21  x00
-rw-rw-r-- 1 logbasex logbasex  12K Thg 5  16 10:21  x01
-rw-rw-r-- 1 logbasex logbasex 2,5K Thg 5  16 10:21  x02
```