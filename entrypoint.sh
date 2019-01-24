#!/bin/bash

# MmM5MzJiZWNkOWJmNTI5Y2JiMWM4NmNk
if [ -z $RPC_PASSWORD ]; then
  echo "Need to set env RPC_PASSWORD"
  exit 1
fi

if [ -z $EXTERNAL_IP ]; then
  echo "Need to set env EXTERNAL_IP"
  exit 1
fi

# 2r1iB96waPcZHFjvsaNxo6NQvu1TJgNxLqtGATaotbY8zJBjFjw
if [ -z $MASTERNODE_PRIV_KEY ]; then
  echo "Need to set env MASTERNODE_PRIV_KEY"
  exit 1
fi

# 0
if [ -z $TX_INDEX ]; then
  echo "Need to set env TX_INDEX"
  exit 1
fi

# insn.cryptocoderz.com
if [ -z $SEED_NODE ]; then
  echo "Need to set env SEED_NODE"
  exit 1
fi

# 10255 207.154.230.81:10255
if [ -z $PORT ]; then
  PORT=10255
fi

# 10255
if [ -z $RPC_PORT ]; then
  RPC_PORT=10257
fi

if [ -z $RPC_ALLOW_IP ]; then
  RPC_ALLOW_IP=localhost
fi

# Lets configure shit
sed -i "s/{{RPC_PASSWORD}}/$RPC_PASSWORD/g" /tmp/INSaNe.conf
sed -i "s/{{RPC_ALLOW_IP}}/$RPC_ALLOW_IP/g" /tmp/INSaNe.conf
sed -i "s/{{RPC_PORT}}/$RPC_PORT/g" /tmp/INSaNe.conf
sed -i "s/{{EXTERNAL_IP}}/$EXTERNAL_IP/g" /tmp/INSaNe.conf
sed -i "s/{{MASTERNODE_PRIV_KEY}}/$MASTERNODE_PRIV_KEY/g" /tmp/INSaNe.conf
sed -i "s/{{TX_INDEX}}/$TX_INDEX/g" /tmp/INSaNe.conf
sed -i "s/{{SEED_NODE}}/$SEED_NODE/g" /tmp/INSaNe.conf
sed -i "s/{{PORT}}/$PORT/g" /tmp/INSaNe.conf

cp /tmp/INSaNe.conf /root/.INSN

# Lets go for takeoff
ulimit -m unlimited
ulimit -v unlimited
ulimit -n 65536

# -E Log to stderr,
# -DD do not daemonize creator,
# -m Size of shared memory allocated in Megabytes
# -M Size of private memory allocated, in Megabytes,
# exec kamailio -DD -E -m 512 -M 64
exec INSaNed -conf=/root/.INSN/INSaNe.conf
