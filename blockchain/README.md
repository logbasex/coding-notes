## Block in BlockChain
- https://viblo.asia/p/nhung-khai-niem-co-ban-cua-blockchain-WAyK8MQEZxX

- ###[**Does every transaction creates a new block in blockchain?**](https://stackoverflow.com/questions/48048037/does-every-transaction-creates-a-new-block-in-blockchain)
  - Bitcoin puts a cap of 2,400 transactions on each of their blocks, but not all blocks have this many. People broadcast transactions to miners and miners put transactions into blocks and distribute them.



## Poof of work
- https://medium.com/coinmonks/simply-explained-why-is-proof-of-work-required-in-bitcoin-611b143fc3e0
- Đảm bảo cho việc không thể giả mạo block vì cứ 10p sẽ có 1 block mới mà không thể tìm được proof of work trong 10p được.


## How it works
- https://www.youtube.com/watch?v=_160oMzblY8
- https://www.youtube.com/watch?v=bBC-nXj3Ng4
- https://www.youtube.com/watch?v=auMA7jIHYvQ

- ![](https://www.euromoney.com/learning/~/media/4305AB9860D34A26ACBD34FCC9422684.png?la=en&hash=31AFCC82578BB687B747D53597B8487825DC2CFA)
- ![https://itnext.io/pulling-the-blockchain-apart-the-transaction-life-cycle-381b76842c6](https://miro.medium.com/max/1050/1*e3_n2X5iIWESS28XiFMEpw.jpeg )

- ###[How many transactions are included in a block chain?](https://www.quora.com/How-many-transactions-are-included-in-a-block-chain)
  - [The block size is limited to 1,000,000 bytes 4,000,000 weight units of data.](https://bitcoin.stackexchange.com/questions/10457/what-is-the-number-of-transactions-in-a-block) Miners may arbitrarily decide from the available valid transactions which to include. The obvious selection policy would be to optimize for maximum fees collected in the block, for which a simple greedy approach would be to select by the fee rate of transactions, i.e. the amount of fee per data size of the transaction.
  **[April 2017:]** Over roughly the past two months, the mean transaction size was about 506 bytes, and the average count of transactions per block was 1,956.
  - Gộp tất cả transaction trong 10p (thời gian để có một block mới) vào 1 block.

- ###[What if everyone stop mining Bitcoin](https://www.quora.com/What-if-everyone-stop-mining-Bitcoin)

## Bitcoin transaction
- https://www.blockchain.com/btc/unconfirmed-transactions

## Longest Chain Rule
- https://bitcoin.stackexchange.com/questions/5540/what-does-the-term-longest-chain-mean?newreg=2e469221abe340738949dc74cd53ae65
- https://www.youtube.com/watch?v=6yIqXMaeEJ4

## Project
- https://github.com/anders94/blockchain-demo 
- https://dev.to/damcosset/trying-to-understand-blockchain-by-making-one-ce4