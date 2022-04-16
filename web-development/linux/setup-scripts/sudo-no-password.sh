#!/bin/bash -x

echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo sh -c "cat - >> /etc/sudoers.d/nopassword; chmod 0440 /etc/sudoers.d/nopassword"
