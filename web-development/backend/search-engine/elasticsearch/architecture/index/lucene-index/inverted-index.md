## Does inverted-index using hashing

An inverted index is a data structure used primarily in search engines to store mapping from content, such as words or numbers, to its locations in a database file, document, or a set of documents. The purpose of an inverted index is to allow fast full-text searches, at a cost of increased processing when adding documents to the database.

Here's how it works with hashing:

1. **Tokenization**: The text of the documents is split into tokens (often words or phrases), creating a list of terms.

2. **Mapping with Hashing**: Each unique token is then hashed to a unique identifier, which acts as a key in the inverted index. Hashing helps in efficiently storing and retrieving the data associated with each token.

3. **Index Building**: For each token, the document IDs where that token appears are listed, often along with the positions within the document. This list of document IDs (and sometimes positions) is called a posting list.

4. **Storage**: The inverted index is stored in such a way that it can be quickly accessed. Given a word, the hash function is used to find the corresponding posting list in the inverted index.

5. **Retrieval**: When a search query is made, it is also tokenized and hashed to find the matching posting lists in the inverted index. The documents referenced in these posting lists are then retrieved and often ranked according to relevance.

In summary, hashing in an inverted index is used to quickly map tokens to their corresponding posting lists, facilitating efficient search and retrieval operations.

----

Let's consider a simple example of how an inverted index works with three short documents:

1. **Doc1**: "apple banana"
2. **Doc2**: "apple apple orange"
3. **Doc3**: "banana orange apple"

First, we tokenize the documents into individual words. Then we use these words to build an inverted index, where each unique word points to a list of documents (and optionally their positions) where it appears.

Here's how the inverted index might look, without using hashing for simplicity:

- **apple**: [1, 2, 2, 3]
- **banana**: [1, 3]
- **orange**: [2, 3]

In a real-world application, these tokens would be hashed to ensure efficient storage and retrieval, but the concept remains the same. The words are keys in the index, and the values are the documents where those words are found.

Now, to illustrate the use of hashing in this context:

1. Compute a hash for each unique word.
    - Let's say `hash("apple")` returns `101`, `hash("banana")` returns `102`, and `hash("orange")` returns `103`.

2. Build the inverted index using these hashes:
    - **101** (hash for "apple"): [1, 2, 2, 3]
    - **102** (hash for "banana"): [1, 3]
    - **103** (hash for "orange"): [2, 3]

When you search for "apple", the system will hash "apple" to find `101` and quickly locate all documents with "apple" in them. This approach uses hashing to efficiently manage and retrieve the list of document IDs in the inverted index.

----
----

## when inverted index lookup is o(1)

Inverted index lookup itself cannot be guaranteed to be O(1) under normal circumstances. This is because the lookup typically involves accessing a data structure (like a hash table) that stores the term and its corresponding document list. Accessing elements in a hash table on average takes constant time, but it can also take longer depending on factors like collisions and hash table size.

However, there are some specific scenarios where an inverted index lookup might achieve an effective constant time behavior:

1. **Very Small Inverted Index:** If the inverted index is very small and can be loaded entirely in memory, a hash table lookup for a specific term might approach O(1) in practice.

2. **Perfect Hashing:**  If a perfect hashing function is used to store terms in the inverted index, then lookup for a specific term would be deterministic and always take constant time. However, perfect hashing techniques can be complex to implement and maintain for large datasets.

3. **Bloom Filters (For Filtering):** In some cases, Bloom filters might be used as a preliminary check in conjunction with the inverted index. Bloom filters are probabilistic data structures that can tell you if a term might exist in the index with high probability. If the Bloom filter quickly eliminates the possibility of a term, then the overall lookup process might feel like O(1). However, Bloom filters might lead to false positives, requiring an actual lookup in the inverted index for confirmation.

It's important to remember that these are special cases. In general, inverted index lookup has a time complexity closer to O(1) on average, but it can vary depending on the size and implementation of the index.

