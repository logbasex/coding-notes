## References
- [How does Tomohiko Sakamoto's Algorithm work?](https://www.quora.com/How-does-Tomohiko-Sakamotos-Algorithm-work)
- [Algorithm on how to find the day of a week ](https://www.hackerearth.com/blog/developers/how-to-find-the-day-of-a-week/)

## Sakamato

```
{thứ 2, thứ 3, thứ 4, thứ 5, thứ 6, thứ 7, chủ nhật}
{    0,     1,     2,     3,     4,     5,        6}
1/1/0001 => thứ 2
1/1/0002 => thứ 3
1/1/0003 => thứ 4
1/1/0004 => thứ 5

0004 là năm nhuận có 366 ngày, 366 mod 7 = 2.
1/1/0005 => thứ 7

Công thức tính ngày đầu tiên của năm bất kỳ (bao gồm năm nhuận chia hết cho 4) là thứ mấy trong tuần: 
day_of_week_index = (y + y/4) % 7

y: mỗi năm đi qua lệch 1 ngày, đi qua y năm chênh lệch y ngày.
y /4: lấy phần nguyên, tính xem đi qua bao nhiêu năm nhuận chia hết cho 4.

nhưng mà những năm chia hết cho 100 không phải là năm nhuận.

1/1/0099 => (99 + 99/4) % 7 = 4 => thứ 5.
1/1/0100 => thứ 6
1/1/0101 => thứ 7 (do năm 0100 không phải là năm nhuận)

Cập nhật công thức.
day_of_week_index = (y + y/4 - y/100) % 7

Tương tự với những năm chia hết cho 100 nhưng không chia hết cho 400 là năm nhuận.
day_of_week_index = (y + y/4 - y/100 + y/400) % 7

-----
Tính ngày đầu tiên của một tháng bất kì trong một năm bất kì.

1/1/0001 => thứ 2
1/2/0002 => 1/1/0002 là thứ 3, nên sau đó đúng 4 tuần ngày 29/1/0002 vẫn là thứ 3 => ngày 1/2/0002 là thứ 6.

Vì chúng ta luôn biết được ngày đầu tiên của năm là thứ mấy nên công thức như sau:

day_of_week_index(1/2/0002) = day_of_week_index(1/1/0002) + (số_ngày_từ ngày_đầu_tiên_của_năm) % 7.
							= day_of_week_index(1/1/0002) + 31 % 7.
							= 1 + 3 = 4 (thứ 6).

day_of_week_index(1/3/0002) = day_of_week_index(1/1/0002) + (31 + 28) % 7.
							= 1 + 3 = 4 (thứ 6).

day_of_week_index = (y + y/4 - y/100 + y/400 + (day_offset_from_start_day_of_year % 7)) % 7

Để đơn giản thì chúng ta sẽ tính trước cho dễ. 

day_of_week_index_by_12_month[] = {0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5};
day_of_week_index = (y + y/4 - y/100 + y/400 + day_of_week_index_by_12_month[m-1]) % 7

Đến đây có một chút vấn đề.
Ví dụ trong năm nhuận 0004 AD chẳng hạn thì trước khi sang tháng 3 (đi qua tháng nhuận) thì day_of_week_index phải trừ đi 1 (vì công thức trên y/4 lấy phần dư = 1).
=> Với năm nhuận cho những ngày đầu tiên của tháng 1, 2

if (m < 3 && leapYear)
	day_of_week_index = day_of_week_index - 1.

Tuy nhiên thì có một cách khác. Đó là áp dụng công thức trừ 1 cho cả năm không nhuận => sau tháng 2 thì index lệch 1 => những tháng sau thì index - 1.

day_of_week_index_by_12_month[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};

if (m < 3)
	day_of_week_index = day_of_week_index - 1.
day_of_week_index = (y + y/4 - y/100 + y/400 + day_of_week_index_by_12_month[m-1]) % 7

-----

tiếp tục..
```