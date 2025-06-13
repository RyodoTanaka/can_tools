#!/bin/bash
sudo ip link add dev $1 type vcan
sudo ip link set up $1
sudo ifconfig $1 txqueuelen 1000
