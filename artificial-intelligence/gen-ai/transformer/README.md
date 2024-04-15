## References
- [Illustrated: Self-Attention](https://towardsdatascience.com/illustrated-self-attention-2d627e33b20a)
- [How LLMs Work ? Explained in 9 Steps — Transformer Architecture](https://medium.com/data-at-the-core/how-llms-work-explained-in-9-steps-transformer-acrhitecture-f35d06d1ee72)

----
----

## What is the "Attention is all you need"

"Attention is All You Need" refers to a influential research paper published in 2 authored by eight Google researchers. It introduced a new deep learning architecture called the Transformer.

The key idea behind the paper is that the  focus mechanism, which had been used successfully in machine translation tasks, could be the sole building block for a powerful neural network. This meant replacing the more complex recurrent neural networks that were commonly used at the time.

The Transformer model based on this idea achieved state-of-the-art results in machine translation tasks, and it has since become a foundation for many other natural language processing applications. You can find more details about the paper in scholarly articles [arxiv.org].

----
----

## what is the idea of transformer architecture, and which problem does it solve to become state-of-the-art?

The core idea behind the Transformer architecture is to rely solely on an **attention mechanism** to learn contextual relationships between words in a sentence. This replaces the recurrent neural networks (RNNs) that were commonly used at the time for tasks like machine translation.

Here's how it addresses a shortcoming of RNNs:

* **RNN Challenges:** RNNs process sequences of data iteratively, but they struggle with capturing long-range dependencies between words.  Imagine trying to understand a sentence where the meaning of a word at the beginning relies on information much further ahead in the sentence. RNNs can struggle with this.

* **Transformer's Attention Mechanism:** The Transformer addresses this by allowing any position in the input sequence to attend to any other position. This means the model can consider the entire sentence at once, rather than needing to process it word by word.  The attention mechanism assigns weights to different parts of the input sequence, indicating how relevant each part is to the current word being processed. By considering these weights, the Transformer can capture long-range dependencies more effectively than RNNs.

This focus on attention led to the name "Attention is All You Need" for the research paper that introduced the Transformer model. The Transformer's ability to handle long-range dependencies effectively is a big reason why it achieved state-of-the-art results in machine translation tasks, and it has become a foundation for many other natural language processing applications. 