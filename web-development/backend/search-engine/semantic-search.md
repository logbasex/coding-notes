## References
- https://blog.bytebytego.com/p/unlock-highly-relevant-search-with
- https://tucanoo.com/semantic-search-tutorial-with-spring-boot-and-openai-embeddings/
- [An overview of semantic search, knowledge graphs & vector databases](https://medium.com/the-techlife/an-overview-of-semantic-search-knowledge-graphs-vector-databases-27588925f33f)

----
----

## What are AI Embeddings?

Before we explain the ‘what’, let’s look at a typical problematic scenario that embeddings aim to solve.

### **The Problem with Conventional Keyword Searches**

A user wants to find research papers on the environmental benefits of renewable energy. They might use search queries like:

-   “Environmental impact of solar power”
-   “How wind energy reduces pollution”
-   “Benefits of renewable sources on ecology”

Now, imagine you have a database of research papers without any records featuring those exact titles. If a research paper has the title “Ecological Advancements through Clean Energy Paradigms”, traditional keyword-based systems might not show it in the search results because they don’t match the exact phrases. This is a missed opportunity, and more importantly, a failure to provide relevant information to the user.

### **Enter Semantic Search**

Here’s where semantic search, empowered by embeddings, makes a difference. Instead of narrowly focusing on exact keyword matches, a semantic search digs deeper into the _meaning_ and _intent_ behind the words. In this scenario, the system understands that “clean energy paradigms” closely relates to “environmental benefits of renewable energy” and presents the user with the research paper, acknowledging its relevance.

### **Embeddings: The Heart of Semantic Search**

So to summarise at a very high level the question “What are embeddings?”. Well, Embeddings are mathematical representations that capture the essence and semantic relationships of words and phrases.

By converting words into vectors in a high-dimensional space, they enable machines to understand nuances, context, and even synonyms, facilitating a more human-like comprehension of language. This capability surpasses traditional keyword-based systems and sets the stage for advanced and intuitive applications in various fields, particularly in AI-driven systems like chatbots and recommendation engines.

### Understanding Embeddings Through Vectors

When we mention translating words into vectors, we mean that we represent each word as a point in a _multi-dimensional_ space. Imagine a 3D space (although in reality, these spaces often have hundreds or thousands of dimensions). Words with similar meanings are located closer together in this space, while unrelated words are farther apart.

**Example:**

Let’s use a simple example to clarify. Assume three words: ‘Fish’, ‘Crustaceans’, and ‘Cephalopods’, all relatable due to they being marine life, In our vector space:

-   ‘Fish’ and ‘Cephalopods’ might be very close to each other as they’re soft-bodied.
-   ‘Crustaceans’, while still categorized as marine life, would be a bit farther from ‘cephalopods’ but not extremely distant.
-   Now, if we introduce an entirely unrelated word, like ‘Toasters’, it would be positioned significantly farther from all these words in the vector space.

![3D embeddings illustration of related and unrelated subjects in 3D vector space](https://tucanoo.com/wp-content/uploads/2023/09/3d-embeddings-1-1024x547.png)

By analyzing the proximity of vectors, semantic search can infer that a document talking about ‘solar benefits’ might be relevant to someone searching about the ‘advantages of sun-powered systems’. This spatial relationship among words in the vector space allows for a richer, more nuanced search experience. To highlight the extent of these multidimensional structures, in this tutorial, we will be using the OpenAI ada-002 model, which uses 1536 dimensions!

### Are embeddings really necessary?

If you’re already familiar with ChatGPT, you may have thought “Well can’t I just feed all my FAQs or knowledge base documents to ChatGPT and let it work out what’s relevant or not?”.

Given the rapid advancements in AI models like ChatGPT, it’s a valid question to wonder about the necessity of embeddings. After all, with such powerful models at our disposal, why bother with another layer of complexity?

#### **1.1 Efficiency and Costs**

Training models like ChatGPT to understand and respond to queries requires substantial computational resources. For every query made, the model processes it in real-time, evaluating vast amounts of data to generate a meaningful response. If you were to feed your entire FAQ or knowledge base to ChatGPT for every query, it would involve high computational costs and increased response times. Embeddings, on the other hand, can pre-process this data, converting the textual information into numerical vectors. This representation allows for quicker similarity checks, drastically reducing the time and resources required to fetch relevant information.

#### **1.2 Precision in Results**

While designers built ChatGPT for general conversational tasks, it might not always extract exact answers from extensive document sets, especially when the answer demands pinpoint accuracy from a specific knowledge base. Embeddings match user queries with the most relevant document in your dataset, improving result precision.

#### **1.3 Handling Large Datasets**

As your knowledge base expands, solely depending on ChatGPT may not be practical. Embeddings offer a scalable solution. You can pre-compute vector representations for each document in your database. When a query arrives, you compute the vector for the query in real-time and execute a similarity search. This method is much faster than sifting through entire documents for every user query. While there’s a cost to produce embeddings, it’s minimal, and it’s common to cache the embeddings generated for each user question, further slashing costs.

#### **1.4 Reducing API Calls**

If you’re using ChatGPT via an API, every question posed incurs a cost. By using embeddings to handle a chunk of standard queries (like frequently asked questions), you can significantly reduce the number of API calls, thus saving costs.

### Generating and storing Embeddings

You will need to consider that Embeddings are not insignificant in terms of data storage space. For example, generating an Embedding for the simple input of a single word hello yields a response of ~33KB. Of course, this is a JSON response, so this is textual data but still, it’s not insignificant when you start to think how many files, or database records you require Embeddings for.

###   
Evaluating the Need for Vector Databases: When and Why?

The undeniable allure of purpose-built vector databases stems from their optimization for handling high-dimensional data and their features tailored for embedding search. But diving straight into a vector database solution without analyzing your specific needs might be like bringing a sledgehammer to crack a nut. Let’s break down the decision-making process.

#### **1.1 Small Datasets: Local Database & Cosine Similarity**

If you’re dealing with modest datasets, with perhaps a few hundred records or less, a specialized vector database might be overkill both in terms of complexity and cost.

**Advantages of using local databases for small datasets:**

-   **Cost-Effective**: No need for additional infrastructure or services.
-   **Simplicity**: Many developers are already familiar with relational databases and can leverage existing systems without steep learning curves.
-   **Control**: No reliance on third-party services ensures you maintain complete control over your data.

You can store embeddings as arrays or serialized objects in a local relational database. When you make a query, you can generate an embedding of the question and compare it with the stored embeddings using a cosine similarity function. This method efficiently ranks results based on their relevance.

#### **1.2 Scaling Up: Handling Larger Datasets**

However, as your dataset grows, there are challenges you’ll encounter:

-   **Efficiency**: Local databases don’t optimize for multi-dimensional similarity search. The time taken to compare vectors will grow linearly with the number of records.
-   **Memory**: Storing thousands of high-dimensional vectors in traditional databases can be taxing on memory and retrieval speeds.
-   **Search Limitations**: Simple cosine similarity might not suffice. Advanced search features like k-NN (k-Nearest Neighbors) become more relevant.

For larger datasets ranging from thousands to tens of thousands of records, you’ll need a solution that balances efficiency with complexity. Here are some alternatives:

-   **Redis with Vector Extensions**: Redis, a popular in-memory data structure store, has extensions like RediSearch and RedisAI that facilitate efficient storage and retrieval of vectors.
-   **Elasticsearch with Vector Fields**: Elasticsearch excels at text-based search, but with the dense\_vector field type, it can also store and search embeddings.

#### **Conclusion:**

Choosing the right storage and retrieval method for embeddings hinges on your dataset’s size, your infrastructure, and the specific use case. While vector databases offer a slew of features optimized for embeddings, they might not always be the best or most economical choice. Always evaluate your needs, anticipate future growth, and then decide on the solution that aligns best with both your present and future objectives.