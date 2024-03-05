## References
- [TF-IDF in Python (Scikit-learn Example) – Term frequency-inverse document frequency](https://www.jcchouinard.com/tf-idf/)
- [Calculate TF-IDF in NLP (Simple Example)](https://www.youtube.com/watch?app=desktop&v=vZAXpvHhQow)
- [Inverse Document Frequency and the Importance of Uniqueness](https://moz.com/blog/inverse-document-frequency-and-the-importance-of-uniqueness)
- 
---
---

## Term

![](images/tf-idf.png)
x
> TF-IDF provides a **rarity** measure.

![](images/tf.png)
![](images/idf.png)

----
----

## Example
 
![](images/tf-idf-1.png)
![](images/tf-idf-2.png)

----
----

## Formula
> Document frequency measures commonness, and we prefer to measure rareness. The classic way that this is done is with a formula that looks like this:


![](images/idf-2.png)

For each term we are looking at, we take the total number of documents in the document set and divide it by the number of documents containing our term. This gives us more of a measure of rareness. However, we don't want the resulting calculation to say that the word "mobilegeddon" is 1,000 times more important in distinguishing a document than the word "boat," as that is too big of a scaling factor.

This is the reason we take the Log Base 10 of the result, to dampen that calculation. For those of you who are not mathematicians, you can loosely think of the Log Base 10 of a number as being a count of the number of zeros - i.e., the Log Base 10 of 1,000,000 is 6, and the log base 10 of 1,000 is 3. So instead of saying that the word "mobilegeddon" is 1,000 times more important, this type of calculation suggests it's three times more important, which is more in line with what makes sense from a search engine perspective.

With this in mind, here are the IDF values for the terms we looked at before:

![](images/idf-1.png)

> **Now you can see that we are providing the highest score to the term that is the rarest.**


The log function in TF-IDF plays a critical role in striking a balance between the importance of common and rare terms:

- **Prevents Under-valuation of Common Terms**: Without the log, common terms appearing in most documents would have IDF values very close to 1, essentially neglecting their contribution. However, these terms can still hold significance in specific contexts (think of function words like "the" or "and" in conveying sentence structure). The log function compresses the difference between IDF values, ensuring common terms, while having lower IDF due to their frequency, still contribute meaningfully to the TF-IDF score.

- **Prevents Over-valuation of Rare Terms**: Conversely, without the log, rare terms appearing in only a few documents would have extremely high IDF values, potentially dominating the TF-IDF score even if they only appear a few times. The log function acts like a dampener, reducing the drastic increase in IDF for very rare terms. This ensures that their importance is reflected without them completely overshadowing the significance of common terms that might be more frequent but still informative within a specific document.

----
----

## Example: Preventing Under-valuation of Common Terms with TF-IDF

Imagine you're searching for information about "healthy recipes" online. Several documents discuss healthy recipes, but some also mention more general cooking terms like "ingredients" or "instructions" - words that appear frequently in many different types of recipes.

**Without the log function in TF-IDF:**

* These common terms like "ingredients" or "instructions" would have an IDF value close to 1 due to their high frequency across various documents. This would significantly decrease their contribution to the overall TF-IDF score, potentially under-valuing their relevance for specific queries like "healthy recipes" even if they provide crucial context.
* This could lead to documents mentioning just the specific healthy ingredients or instructions not ranking as highly as those containing the generic terms, despite being more relevant to the specific search intent.

**With the log function in TF-IDF:**

* The log function compresses the IDF values, preventing a drastic drop for common terms like "ingredients" or "instructions." While their IDF wouldn't be as high as less frequent terms, they wouldn't be completely disregarded.
* This ensures that even these common terms contribute meaningfully to the TF-IDF score, reflecting their importance within the specific context of "healthy recipes." This helps rank documents that discuss both healthy ingredients and essential cooking instructions higher, providing a more accurate and comprehensive search result.

**Example Scenario:**

* **Document 1**: Focuses solely on listing healthy ingredients for various recipes.
* **Document 2**: Provides detailed instructions on how to prepare healthy meals.
* **Document 3**: Discusses both healthy ingredients and cooking instructions for specific recipes.

**Without the log:** Documents 1 and 2 might rank lower due to the under-valuation of "ingredients" and "instructions."

**With the log:** Document 3, which uses both terms alongside specific healthy recipe information, receives a more balanced TF-IDF score, potentially ranking higher and providing a more relevant result for the "healthy recipes" search.

This demonstrates how the log function in TF-IDF helps prevent under-valuation of common terms, ensuring they contribute appropriately to the overall relevance score and facilitating the retrieval of more comprehensive and contextually relevant information for your search queries.


----
----

## Suppose I have 100 documents, if I want to search "healthy recipes", how IF-IDF ranking 100 documents? explain step by step

To search for "healthy recipes" across 100 documents using TF-IDF, we'll follow these steps:

### Step 1: Preprocessing

1. **Tokenize and Normalize**: Break down the text in each document into words (tokens), converting all the words to lowercase to ensure uniformity.
2. **Remove Stop Words**: Filter out common words (like "the", "is", "at", etc.) that do not contribute much meaning to a document.
3. **Stemming/Lemmatization (Optional)**: Reduce words to their base or root form. For example, "cooking" and "cooked" might be reduced to "cook".

### Step 2: Calculate Term Frequency (TF) for Each Term in Each Document

For the query "healthy recipes", calculate the TF for "healthy" and "recipes" in each document.

- For a given document \(d\), the TF of "healthy" would be the number of times "healthy" appears in \(d\) divided by the total number of terms in \(d\).
- Repeat the same for "recipes".

### Step 3: Calculate Inverse Document Frequency (IDF) for Each Term in the Entire Corpus

1. Count how many documents contain the word "healthy". Suppose "healthy" appears in 25 out of 100 documents.
2. Calculate the IDF for "healthy" using the formula: \(\text{IDF}("healthy", D) = \log(\frac{D}{df_t}) = \log(\frac{100}{25})\), where \(D\) is the total number of documents (100) and \(df_t\) is the number of documents containing the term "healthy" (25).
3. Repeat the same process for "recipes".

### Step 4: Calculate TF-IDF Score for "Healthy" and "Recipes" in Each Document

- Multiply the TF of "healthy" in each document by its IDF score to get the TF-IDF score for "healthy" in that document.
- Repeat for "recipes".

### Step 5: Aggregate TF-IDF Scores for the Query Terms in Each Document

- For each document, add the TF-IDF scores of "healthy" and "recipes" together to get an aggregate score that represents the document's relevance to the query "healthy recipes".

### Step 6: Rank the Documents

- Sort the documents by their aggregate TF-IDF scores from step 5, from highest to lowest.
- Documents with higher aggregate scores are considered more relevant to the query "healthy recipes".

### Step 7: Return or Use Ranked Documents

- The sorted list of documents can now be used to recommend the most relevant documents to someone searching for "healthy recipes".

This process allows you to quantitatively assess which documents are most relevant to the search terms "healthy recipes" based on their content. The TF-IDF scores help to prioritize documents that use the terms in a meaningful way, rather than just frequently, by penalizing the scores of terms that are common across many documents.

----
----



