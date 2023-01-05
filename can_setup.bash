#!/bin/bash
sudo chmod 777 $3
sudo slcand -o -c -S5 $2 $3 $1 
sudo ifconfig $1 up
sudo ifconfig $1 txqueuelen 100000
