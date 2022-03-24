- [What is Jmeter plugin](https://www.simplilearn.com/tutorials/jmeter-tutorial/jmeter-plugins)
  - [JMeter Plugins : All You Need To Know About Plugins Manager](https://www.edureka.co/blog/jmeter-plugins/) 
  - [jmeter missing.class com.thoughtworks.xstream.converters.ConversionException](https://stackoverflow.com/questions/45979130/jmeter-missing-class-com-thoughtworks-xstream-converters-conversionexception)
- [View results in a table](https://stackoverflow.com/questions/29252088/jmeter-test-not-running)
  - [Connection time](https://stackoverflow.com/questions/41790285/what-the-difference-latency-time-vs-connect-time-in-jmeter): time taken to establish TCP connection (at TCP layer in TCP/IP model) b/w client and server using TCP Handshake. If TCP Handshake is successful, then the client can send further requests (HTTP request - HTTP layer). If not, the client can't talk to the server. This can happen if the server is not live or busy responding other requests.
- [Thread Count, Ramp-Up Time, Loop Count, Scheduler](http://www.testingjournals.com/5-must-know-features-thread-group-jmeter/)
  - Thread Count defines the number of Users you want to simulate for the execution.
  - Ramp-Up is the amount of time Jmeter should take to get all the threads sent for the execution. Ramp-Up should be sufficient enough to avoid unnecessary and large work load from the beginning of the test execution. For example, if Thread Count is 10 and the ramp-up period is 100 seconds, then Jmeter will take 100 seconds to get all 10 Threads up and running. First thread will be sent on 0th second (beginning of the execution) and then each thread will start after 10 seconds(100/10).
  - Using Loop Count you can specify the number of times to execute the Performance Test. You can select check-box “forever”, it will keep on executing same Test script in loop until you manually stop the execution. There is also an option to manually define the loop count. Now let’s look at some examples to understand Thread Count + Ramp-Up Time + Loop Count combination.
     - Scenario 1 : Thread Count = 20, Ramp Up Time (Seconds) = 100 & Loop Count = 1. Every 5 seconds (100/20) one Thread / Request will hit the server. Execution will start with one request at a time.
     - Scenario 2 : Thread Count = 20, Ramp Up Time (Seconds) = 100 & Loop Count = 4. Every 5 seconds (100/20) 4 Thread / Requests will hit the server. Once the first thread completes the first round of execution, it will start 2nd loop by executing same HTTP request. Execution lasts until all 20 threads executes all HTTP requests 4 times.
- [Hold load](https://sqa.stackexchange.com/questions/10352/what-does-hold-load-for-mean-in-jmeter-and-how-do-i-disable-it)
  - Lets say you have selected hold load for 60 seconds.
    And your test scenario is 30 users trying to log in.
    Then all these users will try to login for as many times as possible for the time span of 60 seconds.
    To verify this look in to the result tree and calculate how many login attempts happened during that period.