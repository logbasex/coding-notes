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