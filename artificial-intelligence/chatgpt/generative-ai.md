## Generative AI concepts
- https://campus.datacamp.com/courses/generative-ai-concepts

### Which of the following best describes generative AI?
- A class of machine learning that can generate new, original content based on input data it has seen

### Working with a generative AI model
- Input prompt => Run the model => Get the response => Use the model output.

### Applications of generative AI
Generative AI can be applied in real-world professions, across a variety of industries and roles. That being said, it isn't a one-stop solution for every problem. In this exercise, you'll test your understanding of generative AI's usage in real-world applications.

- Making original musical compositions
- Creating new artwork and designs
- Helping generate visually-appealing advertisements
- Acting as a personalized tutor for individual students

### Generative AI in the machine learning landscape

1. Generative AI in the machine learning landscape
   In the last video, we got a first look at generative AI models. But how do they fit in with other types of machine learning?

2. Models that analyze
   Many machine learning, or ML, models are known as discriminative models because they discriminate between different types of inputs. These models can answer closed-ended questions, which have a limited, predefined set of answers. For instance, we might train a model to identify if an image is of a puppy or a bagel. These models need to learn from training data, after which, they can guess a correct answer based on inputs, or recommend categories to group data. But that's all.

3. Bagels and puppies
   In this example, let's train our model to discriminate between puppies and bagels by sharing labeled puppy and bagel pictures. We only have four pictures here, but in a real training setting, we could need millions of images to teach the algorithm how to tell the difference.

4. Guessing with confidence
   With enough data, when the model sees a new image, it can generally tell the difference. But that's all--it can only express how confident it is that a picture is a puppy versus a bagel.

5. Models that imagine
   In contrast, another type of machine learning model called generative models flips this on its head. Generative models guess what the data would be for a given prediction. They still require training, just like discriminative models. But they can generate new content that is similar to their training data. If we ask a generative model for a puppy image, we would get just that. It would look similar to what our discriminative model guessed was a puppy.

6. Mixing for effect
   Generative AI integrates discriminative models, generative models, and other statistical techniques. But we can't mash them together haphazardly. The models must work together like parts of a machine to produce high-quality responses. Ultimately, these mashups can produce beautiful creative works, like the examples we saw previously.

7. Generative adversarial networks (GANs)
   Let's take the example of generative adversarial networks, or GANs. This is a type of generative AI that trains a generative model and a discriminative model together. They compete with one another, one trying to trick the other. Afterward, they share notes and each gets better over time.

8. Bagel Puppy GAN
   The generator creates confusing images, attempting to fool the discriminator. Meanwhile, the discriminator tries to guess correctly. After every round, they compare notes and each model learns from the results. The two models compete with each other over many rounds until the generator gets very good at creating bagel pictures that are so puppy-like or vice versa that they fool the discriminator.

9. Artificial general intelligence (AGI)
   But where is this all headed? A long-time goal of the Artificial Intelligence community is to create generative AIs that exhibit human-like intelligence. Beyond just generating new data similar to previous data, such Artificial General Intelligence, or AGI, would have a broad range of knowledge about the world, be able to reason across different domains, possess social skills for interacting with humans, and have the ability to think creatively and reason critically. Finally, AGI would have other human-like cognitive competencies, such as sight and language.

10. Use the right tool for the job
    Now that we understand how discriminative models, generative AI, and AGI relate, we can consider which type applies in different situations. Discriminative models can be used to predict the weather, categorize a large collection of books, or classify puppy and bagel images. Generative AI can create code for a website, customer service responses, or pictures of aquatic felines. AGI, which may arrive in the coming decades, would be able to complete traditionally human jobs on its own.

----

"Generative AI" and "AGI" (Artificial General Intelligence) are related concepts in the field of artificial intelligence, but they refer to different levels of AI capabilities.

1. **Generative AI:**
   Generative AI refers to AI systems that have the ability to generate content, such as images, text, music, or other forms of data. These systems are trained on large datasets and use various techniques to create new and original content that resembles the patterns and styles present in the training data. Generative AI includes models like Generative Adversarial Networks (GANs) and language models like GPT-3. These models can produce content that is often indistinguishable from human-created content, leading to applications in creative fields, content generation, and more.

2. **AGI (Artificial General Intelligence):**
   AGI, on the other hand, represents a higher level of AI capability. It refers to a hypothetical AI system that possesses general intelligence similar to human intelligence. Unlike specialized AI systems that are designed for specific tasks (narrow or weak AI), AGI would have the ability to understand, learn, and perform a wide range of tasks at a human-level or beyond. An AGI system would exhibit cognitive abilities such as reasoning, problem-solving, common sense understanding, and adaptability across different domains. It would be capable of transferring knowledge from one domain to another without the need for explicit programming or extensive retraining.

In essence, while generative AI focuses on the ability to create content that matches patterns in the training data, AGI is the ultimate goal of achieving human-like intelligence and versatility in artificial systems. As of now, AGI remains a theoretical concept, and the field of AI is still working on developing and refining narrow AI systems with specific capabilities.

### The evolution of generative AI

1. The evolution of generative AI
   Let's explore the key factors and milestones that have brought generative AI into products that people around the world use every day.

2. Generative AI burst on the scene in 2023
   Generative AI burst onto the global mainstream in 2023, with the launch of multiple generative AI consumer products. The chatbot ChatGPT made history when it reached 100 million monthly users in only two months, something that took viral social media platforms like TikTok and Instagram several times longer to achieve.

3. Key factors driving development
   Leading up to that historical moment, the field of generative AI evolved over many years, enabled by increased computing power, massive datasets for training, market and geopolitical competition, and novel model designs and tools.

4. Computational power allowed large models
   By 2023, models already required 100 million times more computing power than models from 10 years earlier. Innovations allowing multiple computations to happen simultaneously, known as parallelization, allowed the training of larger and more complex models. It was enabled by specialized processors, such as Graphics Processing Units, or GPUs, and Tensor Processing Units, or TPUs. Cloud computing has also driven generative AI forward, enabling researchers to access and scale computing resources as needed. Finally, improvements in software frameworks and libraries optimized the utilization of computing power.

5. Models improved with massive datasets
   As data availability has exploded exponentially in recent years, data-hungry generative AI models have had more to train on. Additionally, breakthroughs in techniques for creating synthetic data that can augment and enhance real data further scale the availability of training data.

6. Competitive pressures encouraged faster development
   Big Tech companies and governments also spurred generative AI development to gain commercial or political advantages against their peers. But the core of generative AI's evolution is innovation in models.

7. GANs unleashed high quality generation
   We're already familiar with the first model innovation: generative adversarial networks, or GANs. Remember that these models consist of generator models and discriminator models that compete with one another. Introduced in 2014, GANs brought a massive leap in the quality of results that generative techniques could produce.

8. Transformers brought context and coherence
   The second model innovation we'll discuss is the transformer. This powerful model type is designed to understand and process text by considering multiple words and their relationships at once, rather than focusing on individual words one at a time. Consider the sentence, "The animal didn't cross the street because it was too tired." Here, the model recognizes that "it" refers to the animal, emphasized by the blue coloring. Now, take the sentence, "The animal didn't cross the street because it was too wide." In this case, the model understands that "it" refers to the street.

9. Transformers brought context and coherence
   Transformers excel at grasping the context of a given text, which allows them to generate more coherent responses. By analyzing the relationships between words and seeing the text as a whole, transformers can generate responses that feel natural and informative, like an educational chatbot that keeps a student on track to complete a lesson.

10. RLHF engaged user feedback
    A third important innovation is Reinforcement Learning with Human Feedback, or RLHF. This technique improves models by applying feedback from users. Reinforcement learning teaches models through trial-and-error interactions. This allows them to learn how to achieve complex and specific goals. The human feedback part of RLHF comes from users scoring model responses. This feedback becomes part of a retraining process that helps the model outputs better match what users score highly.

11. RLHF engaged user feedback
    Image generation AI company Midjourney allows users to rate images. Midjourney can then use this feedback to steer their model toward higher-rated responses and away from lower-rated ones. Public products can accumulate massive amounts of feedback from their users, creating a flywheel that speeds up development further.

![image](https://user-images.githubusercontent.com/22516811/259396022-aa3a87bf-ad5e-4e6f-9d48-4c3d45aacee1.png)