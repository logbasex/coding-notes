## [How do hackers `brute force` passwords when most of the time you're only allowed a limited number of tries?](https://www.quora.com/How-do-hackers-brute-force-passwords-when-most-of-the-time-youre-only-allowed-a-limited-number-of-tries)
- Hackers usually don’t knock on the front door. They enter through the back window where nobody is watching.
  
  Brute-forcing usually means that a hacker has already obtained the encrypted (hashed) passwords and has them in his posession. In some cases, he can do this just by crafting a special message and sending it to a vulnerable website. The spurious message will trick the website into doing things it was not designed to do, such as replying with a list of user accounts. If the website was not designed to use encrypted passwords, it’s game over.
  
  After the hacker gets the encrypted passwords on his computer, he can get as many additional computers as he wants and run password crackers on them in parallel at his own convenience. The only thing that’s stopping him now is the quality of the passwords and the quality of encryption.
- One of my sites was recently subjected to a distributed brute force attack for several hours. I looked at the logs and noticed an interesting fingerprint:
  
  - The username **redacted** was brute-forced exactly 7 times from a particular IP address, then I never saw that IP address again.
  - At any given time, three different IP addresses were trying to log on to that username, using a variety of passwords.
  - After a particular IP address had tried seven passwords and failed seven times, that IP address would stop trying, and exactly 21 seconds later a new IP address would join the attack.
  Fascinating, huh? That’s an example of a distributed attack. The attacker controls a huge number of computers, probably one computers infected with a virus. He knows that if an IP address fails too many times, that IP address will be locked out. Solution: Keep trying from hundreds of different IP addresses.
  
  This is a distributed brute force attack. It’s much like a distributed denial of service attack, in that the attack is conducted from a huge number of different places at once.  