#!/bin/bash
sudo chmod 777 $1
sudo slcand -o -c -s5 $1 $2
sudo ifconfig $2 up
sudo ifconfig $2 txqueuelen 100000
