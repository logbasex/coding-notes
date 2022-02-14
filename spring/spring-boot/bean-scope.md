[There are **five** types of spring bean scopes](https://www.journaldev.com/21039/spring-bean-scopes):


- **`singleton`** 
    - only one instance of the spring bean will be created for the spring container. **This is the default spring bean scope**. While using this scope, make sure bean doesn’t have shared instance variables otherwise it might lead to data inconsistency issues.
- **`prototype`** 
  - A new instance will be created every time the bean is requested from the spring container.
- **`request`** 
  - This is same as prototype scope, however it’s meant to be used for web applications. A new instance of the bean will be created for each HTTP request.
- **`session`** 
  - A new bean will be created for each HTTP session by the container.
- **`global-session`** 
  - This is used to create global session beans for Portlet applications.

-----

[Factory pattern with prototype bean](https://stackoverflow.com/a/43594962/10393067)
