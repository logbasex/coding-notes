[Normalization vs. Denormalization](https://betterprogramming.pub/normalization-vs-denormalization-7470bb20618d)

Normalization and denormalization are optimized for different things. It’s a good idea to use both.
For your source-of-truth, it’s best to have your data normalized so when it needs to be updated you change it in one location and it’s updated perfectly throughout the system.
For speedy delivery of data, it’s best to take your normalized data and derive a denormalized ready-to-consume form from it. This denormalized form doesn’t need to be perfect, just fast. The perfection is still sustained in the normalized form.

Always normalize, but denormalize for speed.

-----

