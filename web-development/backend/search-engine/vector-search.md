## References
- [Vector Search: Powering the Next Generation of Applications](https://www.youtube.com/watch?v=H8EC002zS-0)
- [Vector Databases: A Beginner’s Guide!](https://medium.com/data-and-beyond/vector-databases-a-beginners-guide-b050cbbe9ca0)

----
----

> Vector databases store data by using vector embeddings. Vector embeddings in vector databases refer to a way of representing objects, such as items, documents, or data points, as vectors in a multi-dimensional space. **Each object is assigned a vector that captures various characteristics or features of that object**.
>
> These vectors are designed in such a way that **similar objects have vectors that are closer to each other in the vector space, while dissimilar objects have vectors that are farther apart**.

----

## How to convert text into vectors.

Converting text into vectors, a process essential in Natural Language Processing (NLP), involves transforming textual information into numerical form to be processed by machine learning algorithms. Key methods for this include:

1. **Bag of Words (BoW):** Represents text as a multiset of its words, focusing on word frequency while ignoring order and grammar.

2. **TF-IDF (Term Frequency-Inverse Document Frequency):** Evaluates word importance in a document relative to a corpus, balancing word frequency with its commonness across documents.

3. **Word Embeddings (e.g., Word2Vec, GloVe):** Dense vector representations of words where similar words have similar vectors, capturing semantic relationships.

4. **Contextual Embeddings (e.g., BERT, GPT):** Advanced embeddings sensitive to word context, offering a more nuanced understanding of language.

5. **One-Hot Encoding:** Simple vector representation with binary values, where each word is uniquely represented by a vector with a single '1' and the rest '0's.

6. **Character Embeddings:** Focus on representing individual characters as vectors, useful for languages with unclear word boundaries.

7. **Sentence/Document Embeddings:** Creating vector representations for whole sentences or documents, using models like Doc2Vec or BERT-based sentence transformers.

The choice of method depends on the specific NLP task and the nature of the text data. Tools and libraries like NLTK, Scikit-learn, Gensim, TensorFlow, and PyTorch are commonly used for implementing these techniques.