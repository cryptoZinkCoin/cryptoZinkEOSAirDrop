# zinc.token

EOS Token Contract with "Burning" and "Signup" built in (for making the token RAM cheap)

This token uses the standard eosio.token contract with two modifications.

### To signup for an airdrop:

`cleos push action zinctoken signup '{"owner":"iwanttokens1","quantity":"0.0000 ZNK"}' -p iwanttokens1@active`

The signup function allows an account to create a balance entry using their own personal ram.

The signup restricts the quantity to 0 however you could configure this in the contract code to allow a "signup bonus".

You would have to add some controls to prevent double signups though, so 0 quantity signup is safest.

### To burn tokens run the command:

`cleos push action zinctoken burn '{"from":"tokensowner1","quantity":"1.0000 ZNK","memo":"remove ZNKs"}' -p tokensowner1@active`

The burn function burns the token from the "from account" and also reduces the supply.

The burn function makes sure you can't burn more tokens than supply.

The burn function has been modified to allow you to burn your zero balance if you don't want to wait for the airdrop.

### Don't need to pay ram if you can get potential token holders to register first:

Two additional commands have been added:

1. issuefree
1. transferfree

These commands work the same as issue and transfer, however they fail if the destination does not have a table row already.

The purpose of this is to prevent you accidentally paying RAM for accounts that unregister from the airgrab (via burn) after you've taken a snapshot.
