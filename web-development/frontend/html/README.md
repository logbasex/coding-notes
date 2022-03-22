## <!DOCTYPE html>
- [Standards vs Quirks mode](https://www.youtube.com/watch?v=G1MOlh5uJYE)
  - Đại khái là quirks mode for compatible with previous version. Nếu không có dòng này thì sẽ bật quirks mode, một số code syntax cũ kĩ không chạy với standtard mới nhưng với quirk mode thì chạy vẫn ngon.
  - https://developer.mozilla.org/en-US/docs/Web/HTML/Quirks_Mode_and_Standards_Mode
- **<!**
  - Markup declaration open
  - https://stackoverflow.com/a/16324326/10393067
  - [exclamation mark](https://www.sololearn.com/Discuss/2757563/where-is-the-use-of-exclamation-point-%EF%B8%8F-in-html)
- [HTML doctype across version](https://www.geeksforgeeks.org/html-doctypes/)
  - ```html
    <!--html 5.0-->
    <!DOCTYPE html>
    ```
  - ```html
    <!--html 4.01 strict-->
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
    ```  
- [syntax](https://html.spec.whatwg.org/multipage/syntax.html#the-doctype)

  A DOCTYPE must consist of the following components, in this order:
  - A string that is an **ASCII case-insensitive** match for the string "<!DOCTYPE".
  - One or more ASCII whitespace.
  - A string that is an ASCII case-insensitive match for the string "html".
  - Optionally, a DOCTYPE legacy string.
  - Zero or more ASCII whitespace.
  - A U+003E GREATER-THAN SIGN character (>).
## DTD (Document type definition)