 ## [Autosuggest Retrieval Data Structures & Algorithms](https://medium.com/related-works-inc/autosuggest-retrieval-data-structures-algorithms-3a902c74ffc8)

- Brute Force
- Binary Search
- Edge N-Grams
- N-grams (aka Fuzzy Search)
- Tries
- Deterministic Finite Automata (DFAs)
- Finite State Transducers (FSTs)

----
----

## [Building an Autosuggest Corpus, Part 1](https://medium.com/related-works-inc/building-an-autosuggest-corpus-part-1-3acd26056708)

Here are the components of our auto suggest system:

1.  **Autosuggest Corpus** — A static dataset of suggestions that we can offer users. This is computed offline at a scheduled interval and loaded into the engine.
2.  **Engine** — A REST API responsible for **Retrieval** (getting the list of candidate suggestions for a given user input) and **Ranking** (ordering the retrieved suggestions).
3.  **Client** — The client application that runs in your browser, asks the engine for results, and displays them to the user.