## Performance
- https://www.baeldung.com/java-regex-performance
- https://stackoverflow.com/questions/63297763/why-is-this-regular-expression-so-slow-in-java
- [Atomic Group](https://www.regular-expressions.info/atomic.html)
  - [Everything you need to know about Regular Expressions](https://towardsdatascience.com/everything-you-need-to-know-about-regular-expressions-8f622fe10b03?gi=686abc1add3c)
- [Catastrophic Backtracking](https://www.regular-expressions.info/catastrophic.html)
- [How can I recognize an evil regex?](https://stackoverflow.com/questions/12841970/how-can-i-recognize-an-evil-regex?noredirect=1&lq=1)
    - Be careful how quantifiers are used in combination with other operators.
- [Performance of Regular Expressions](https://medium.com/textmaster-engineering/performance-of-regular-expressions-81371f569698)
  - Must read
- [Regular expression Denial of Service - ReDoS](https://owasp.org/www-community/attacks/Regular_expression_Denial_of_Service_-_ReDoS)  
- [Performance difference between Java Regex and String based replace operations](https://www.logicbig.com/tutorials/core-java-tutorial/java-regular-expressions/performance.html)


## Cheatsheet
  - https://cheatography.com/davechild/cheat-sheets/regular-expressions/

### String replacement
```shell
$n        # nth non-passive group
$2        # "xyz" in /^(abc(xyz))$/
$1        # "xyz" in /^(?:abc)(xyz)$/
$`        # Before matched string
$'        # After matched string
$+        # Last matched string
$&        #Entire matched string

# https://stackoverflow.com/questions/16431181/what-is-the-use-of-the-ampersand-in-regular-expressions-in-perl
```