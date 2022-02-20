## [Best Practices in Designing an Effective API](https://azeynalli1990.medium.com/best-practices-in-designing-an-effective-api-b021357242e9)

```
// refer to collections:
GET: {base_url}/testcases => a collection of testcases
GET: {base:_url}/testcases/{testcase_id} => specific testcase with given id

// use collections in plural
GET: {base_url}/action => semantically incorrect
GET: {base_url}/actions => correct implementation

// use nouns instead of verbs
POST: {base_url}/actions/saveAction/{action_id} => no need to refer to http method with verb => incorrect
POST: {base_url}/actions/{action_id} => correct implementation

// use logical nesting
GET: {base:_url}/testcases/{testcase_id}/results => getting results of a specific testcase with given id
PUT: {base:_url}/testcases/{testcase_id}/comments => updating comments of a specific testcase with given id

// use versioning 
DELETE: {base:_url}/api/v1/testcases/{testcase_id} => deleting given testcase inversion 1 
DELETE: {base:_url}/api/v2/testcases/{testcase_id} => deleting given testcase inversion 2

// use OPTIONS
OPTIONS: {base_url}/users => fetching all allowed request types on /users Path

// add Hypermedia
without Hypermedia:
GET: {base:_url}/users/1
{
  "id": 1,
  "name": "Ali Zeynalli",
}
with Hypermedia:
{
  "id": 1,
  "name": "Ali Zeynalli",
  "_links": {
    "self": {
      "href": "http://localhost:8080/users/1"
    },
    "users": {
      "href": "http://localhost:8080/users"
    }
  }
}
```