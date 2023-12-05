### Logarithmic Time Complexity – O(log n)

> Log n in big o <=> Log2 n <=> Log n base 2.
> 
> Log n base x <=> Log (base x) của n (integer) có kết quả là y => có nghĩa rằng x cần nâng lũy thừa y lần để tạo thành n.
> 
> Base 2 => số 2 cần nâng lũy thừa bao nhiêu lần để ra kết quả.
> 
> Nếu phép lũy thừa cơ số x là phép tính cho biết kết quả. Thì **logarithm cơ số x là phép nghịch đảo của lũy thừa** cho biết số mũ (maybe decimal exponents - log 3 base 2).
> 
```
log2 (3) = log2 (2 * 1.5) 
= log2 (2) + log2 (1.5) 
= 1 + log2 (1.5) 
> 1 + log2 (1.4142...)
= 1 + log2 (2 ^ 0,5) 
= 1 + 0.5 
= 1.5   
=> log2 (3) > 1.5 (1)

log2 (3) = log2 (4 / (4/3)) 
= log2 (4) - log2 (4/3)
= 2 - log2 (1.3333)
< 2 - log2 (1.31..)
= 2 - log2 (2 ^ 0.4)
= 2 - 0.4
= 1.6
=> log2 (3) < 1.6 (2)

(1)(2) => 1.5 < log2 (3) < 1.6

[What is the best way to calculate log without a calculator?](https://math.stackexchange.com/questions/820094/what-is-the-best-way-to-calculate-log-without-a-calculator)
```

```shell
for (int i = 1; i < n; i = i * 2){
    System.out.println("Hey - I'm busy looking at: " + i);
}
```

### Log-Linear Time Complexity - O (n log n)
- https://www.youtube.com/watch?v=K3NluEdHkao

###
```shell
O(n) = O(n * 1)
O(n2) = O(n * n)
O(n log n) = O(n * log n)
```