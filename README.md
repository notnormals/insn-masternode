# Description
Docker image for INSANE coin masternode setup

## Build
```
./build.sh
```

or

```
docker build -t karstenjakobsen/insn-masternode:latest .
```

## Run
```
./run.sh
```

or

```
docker run \
  --name insn-masternode \
  --net=host \
  --restart=always \
  -v ~/.INSN:/root/.INSN \
  -e RPC_PASSWORD=12345678 \
  -e EXTERNAL_IP=192.168.10.111 \
  -e MASTERNODE_PRIV_KEY=secretprivatekey \
  -e TX_INDEX=0 \
  -e SEED_NODE=insn.cryptocoderz.com \
  -d \
  karstenjakobsen/insn-masternode:latest
```
