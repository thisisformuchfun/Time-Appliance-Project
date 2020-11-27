#!/bin/bash

BC0_NIC_dev=eth40
BC1_NIC_dev=eth41
BC_ns=BC
BC0_IP_ADDR=192.168.3.109/24
BC1_IP_ADDR=192.168.4.108/24

ip netns add $BC_ns

ip link set dev $BC0_NIC_dev netns $BC_ns
ip link set dev $BC1_NIC_dev netns $BC_ns

ip netns exec $BC_ns ip link set lo up

ip netns exec $BC_ns ip addr add $BC0_IP_ADDR dev $BC0_NIC_dev
ip netns exec $BC_ns ip link set $BC0_NIC_dev up
ip netns exec $BC_ns ip addr add $BC1_IP_ADDR dev $BC1_NIC_dev
ip netns exec $BC_ns ip link set $BC1_NIC_dev up

ip netns exec $BC_ns phc2sys -w -m  -s $BC0_NIC_dev -c $BC1_NIC_dev

