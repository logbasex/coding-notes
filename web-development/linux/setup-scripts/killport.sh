#!/bin/bash -x

echo "Enter ports split by space: "
read -a arr
for port in "${arr[@]}"
  do
    kill -9 "$(sudo lsof -t -i:"$port")"
  done


# The variable $@ is the array of all the input parameters
#for port in "$@"
#  do
#    kill -9 "$(sudo lsof -t -i:"$port")"
#  done