##[A Dive into the Facebook Newsfeed Architecture](https://algodaily.com/lessons/dive-into-facebook-newsfeed-architecture)

---

##[Is Redis or MongoDB better for a news feed?](https://www.quora.com/Is-Redis-or-MongoDB-better-for-a-news-feed)

Redis requires much more memory than mongoDb but therefore is much faster.

I would suggest using both. Use mongoDb as your main data source and cache all data that concerns the last few days in a redis. You can set redis cache expiring seconds property to your purpose.


If you create news-entries then write it into both mongoDb and redis.
It will expire according to your settings
If you want to display news try to access redis, if it doesn't return data then access mongoDB.
If you update data then update your mongoDB data and then reload it into redis.

You just have to make sure redis mirrors your mongoDb correctly. Then you can find your perfect settings, like what specific data has to be cached, for how long, maybe there are power users... etc.


--------

## [What are the best practices for building something like a news feed?](https://www.quora.com/What-are-the-best-practices-for-building-something-like-a-news-feed)

---

## [How do news feed algorithms work?](https://www.quora.com/How-do-news-feed-algorithms-work)

## [Did Facebook develop a custom in-memory database to manage its news feeds?](https://www.quora.com/Did-Facebook-develop-a-custom-in-memory-database-to-manage-its-news-feeds)
