### 7.1.4
- If in doubt, measure. Turning a sequential stream into a parallel one is trivial but not always the right
thing to do. As we already demonstrated in this section, a parallel stream isn’t always faster than the
corresponding sequential version. Moreover, parallel streams can sometimes work in a
counterintuitive way, so the first and most important suggestion when choosing between sequential
and parallel streams is to always check their performance with an appropriate benchmark.

- Watch out for boxing. Automatic boxing and unboxing operations can dramatically hurt performance.
Java 8 includes primitive streams ( IntStream , LongStream , and DoubleStream ) to avoid such
operations, so use them when possible.

- Some operations naturally perform worse on a parallel stream than on a sequential stream. In
particular, operations such as limit and findFirst that rely on the order of the elements are expensive
in a parallel stream. For example, findAny will perform better than findFirst because it isn’t
constrained to operate in the encounter order. You can always turn an ordered stream into an
unordered stream by invoking the method unordered on it. So, for instance, if you need N elements
of your stream and you’re not necessarily interested in the first N ones, calling limit on an unordered
parallel stream may execute more efficiently than on a stream with an encounter order (for example,
when the source is a List ).
- Consider the total computational cost of the pipeline of operations performed by the stream. With N
  being the number of elements to be processed and Q the approximate cost of processing one of these
  elements through the stream pipeline, the product of N*Q gives a rough qualitative estimation of this
  cost. A higher value for Q implies a better chance of good performance when using a parallel stream.
  
- For a small amount of data, choosing a parallel stream is almost never a winning decision. The
  advantages of processing in parallel only a few elements aren’t enough to compensate for the
  additional cost introduced by the parallelization process.
- Take into account how well the data structure underlying the stream decomposes. For instance, an
  ArrayList can be split much more efficiently than a LinkedList , because the first can be evenly
  divided without traversing it, as it’s necessary to do with the second. Also, the primitive streams
  created with the range factory method can be decomposed quickly. Finally, as you’ll learn in section
  7.3, you can get full control of this decomposition process by implementing your own Spliterator .
  
- The characteristics of a stream, and how the intermediate operations through the pipeline modify
  them, can change the performance of the decomposition process. For example, a SIZED stream can
  be divided into two equal parts, and then each part can be processed in parallel more effectively, but a
  filter operation can throw away an unpredictable number of elements, making the size of the stream
  itself unknown.