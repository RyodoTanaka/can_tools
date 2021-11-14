#!/bin/bash
sudo ip link add dev can0 type vcan
sudo ip link set up can0
sudo ifconfig can0 txqueuelen 1000
