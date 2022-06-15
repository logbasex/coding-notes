## [I/O Stream tutorial](https://docs.oracle.com/javase/tutorial/essential/io/streams.html)

- A stream is a sequence of data.

- A program uses an input stream to read data from a source, one item at a time
  - ![](https://docs.oracle.com/javase/tutorial/figures/essential/io-ins.gif)
- A program uses an output stream to write data to a destination, one item at time:
    - ![](https://docs.oracle.com/javase/tutorial/figures/essential/io-outs.gif) 

## [Buffer reader, Buffer writer](https://medium.com/@isaacjumba/why-use-bufferedreader-and-bufferedwriter-classses-in-java-39074ee1a966)

-  BufferedReader's **read() method reads a single character** only
  ```shell
  public static void main(String [] args) throws IOException {

          BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
          System.out.println("Enter number?");
          int num = reader.read();
          System.out.println("You  entered " + num);
  }
  ```
  
  
 ## Stream
 
 ### File descriptor
 
 - [What are file descriptors?](https://www.quora.com/What-are-file-descriptors)
  - https://www.quora.com/What-are-file-descriptors/answer/Steve-Eng
  - https://www.quora.com/What-is-a-Unix-file-descriptor-in-laymans-terms
  - https://linuxmeerkat.wordpress.com/2011/12/02/file-descriptors-explained/
  - https://copyconstruct.medium.com/nonblocking-i-o-99948ad7c957
  - https://www.quora.com/Whats-the-difference-between-inode-number-and-file-descriptor/answer/Brian-Bi

 ![image](https://user-images.githubusercontent.com/22516811/173639693-4c13214d-3d92-4e38-8166-7de9739739b1.png)
 
 ### Why we need close stream
 - https://stackoverflow.com/questions/5155073/closing-the-streams-of-i-o
 - https://stackoverflow.com/questions/515975/closing-streams-in-java
