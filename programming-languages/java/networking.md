## [HttpUrlConnection](https://stackoverflow.com/a/17665696/10393067)
- ```shell
    void get(URL url) {

      // this does no network IO 
      HttpURLConnection conn = url.openConnection();
      InputStream in;
      int http_status;
      try {

        // this opens a connection, then sends GET & headers 
        in = conn.getInputStream(); 

        // can't get status before getInputStream.  If you try, you'll
        //  get a nasty exception.
        http_status = conn.getResponseCode();

        // better check it first
        if (http_status / 100 != 2) {
          // redirects, server errors, lions and tigers and bears! Oh my!
        }
      } catch (IOException e) {
        // Something horrible happened, as in a network error, or you
        //  foolishly called getResponseCode() before HUC was ready.
        // Essentially no methods of on "conn" now work, so don't go
        //  looking for help there.
      }
      
      try {
        // now you can try to consume the data
        try_reading(in);
      } catch (IOException e) {
        // Network-IO lions and tigers and bears! Oh my!
      } finally {
        // Do like Mom said and practice good hygiene.
        conn.disconnect(); 
      }
    }
    ```
- Now, suppose you want to do a POST instead of a GET.
- ```shell
    void post(URL url, byte[] payload) {

  // this does no network IO.
  HttpURLConnection conn = uri.openConnection(); 

  // tells HUC that you're going to POST; still no IO.
  conn.setDoOutput(true); 
  conn.setFixedLengthStreamingMode(payload.length); // still no IO
  InputStream in;
  OutputStream out;
  int http_status;
  try {
    // this opens a connection, then sends POST & headers.
    out = conn.getOutputStream(); 

    // At this point, the client may already have received a 4xx
    //  or 5xx error, but don’t you dare call getResponseCode()
    //  or HUC will hit you with an exception.
  } catch (IOException e) {
    // some horrible networking error, don't try any methods on "conn".
  }
  try {
  
    // now we can send the body
    out.write(payload);

    // NOW you can look at the status.
    http_status = conn.getResponseCode();
    if (http_status / 100 != 2) {
      // Dear me, dear me
    }
  } catch (IOException e) {
    // Network-IO lions and tigers and bears! Oh my!
  }

  // presumably you’re interested in the response body
  try {

    // Unlike the identical call in the previous example, this
    //  provokes no network IO.
    in = conn.getInputStream(); 
    try_reading(in);
  } catch (IOException e) {
    // Network-IO lions and tigers and bears! Oh my!
  } finally {
    conn.disconnect(); // Let's practice good hygiene
  }
  ```

    