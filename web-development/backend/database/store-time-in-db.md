https://developpaper.com/how-to-store-time-in-database/

1. Don’t use string to store date
   - String takes up more space!
   - The date comparison efficiency of string storage is relatively low (character by character comparison), and can not be calculated and compared by date related API.
2. The choice between datetime and timestamp
    - 2.1 datetime type has no time zone information
    - 2.2 datetime type consumes more space
        - DateTime ：1000-01-01 00:00:00 ~ 9999-12-31 23:59:59
          Timestamp： 1970-01-01 00:00:01 ~ 2037-12-31 23:59:59
3. look at the storage space of MySQL date type again
4. Is numerical timestamp a better choice?