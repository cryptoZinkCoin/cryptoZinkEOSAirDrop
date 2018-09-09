#!/bin/bash

SYMBOL="ZNK"
ISSUER="add owner contract account here"
SNAPSHOT_FILE="snapshot.csv"
MEMO="CryptoZinc airdrop, register for bonus drop here: http://cryptozinc.io/"

for line in $(cat $SNAPSHOT_FILE); do
    ACCOUNT=$(echo $line | tr "," "\n" | head -2 | tail -1)
    AMOUNT="1000.0000"
    ACCOUNT=$(eval echo $ACCOUNT)
    CURRENT_BALANCE=$(cleos get table $ISSUER $ACCOUNT accounts | grep $SYMBOL) 
    if [[ -z $CURRENT_BALANCE ]]; then
        echo "Airdropping $AMOUNT $SYMBOL to $ACCOUNT from $ISSUER"
        cleos -u "https://eos.greymass.com" push  action $ISSUER transfer "[\"$ISSUER\", \"$ACCOUNT\", \"$AMOUNT $SYMBOL\", \"$MEMO\"]" -p $ISSUER@active
    else
        echo "Skipping $ACCOUNT"
    fi 
done
