#!/usr/bin/env sh

echo "| Starting replica."
dfx start --background --clean > /dev/null 2>&1
dfx deploy --no-wallet

j=0
while [ $j -le 4 ]; do
    echo "| Getting new raw (async) UUID ($j): \c"
    dfx canister --no-wallet call uuid newAsync
    echo "| Getting new raw (sync) UUID ($j):  \c"
    dfx canister --no-wallet call uuid newSync
    j=$(( j + 1 ))
done

dfx -q stop > /dev/null 2>&1
