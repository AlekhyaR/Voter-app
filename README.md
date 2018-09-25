# Voter-app

Truffle gives us the boxes which has packages of boiler plate code, that can be unboxed by 
truffle petshop box - this is published by truffle to support the ethereum desktop tutorial
- truffle unbox pet-shop

Commands:

  Compile:        truffle compile
  Migrate:        truffle migrate
  Test contracts: truffle test
  Run dev server: npm run dev

- Contracts folder - where smart contracts will leave
We already have contracts in directory in migrations.sol -> this is the migration file which going to take while we deploy our smart contract to blockchain
truffle.js -> will contain the configuration settings 

smart contract is where all business logic of app is going to live, is where we write all of our code that going to read, write to the ethereum blockchain, its where we are going to list all of our candidates, that run in the election where it going to keep track of everything voted in the election and also its the place where we write all the bussiness rule of election like where the account can only vote one time in an election
- So lets create a new in contracts directory name Election.sol
- first declare the version of solidility we are going to using it

- create a election file 
- now check whether we can interact in contract in console for that we need to create migration to deploy our contract to our local blockchain

run - truffle migrate
output
------
Running migration: 1_initial_migration.js
  Deploying Migrations...
  ... 0x4514d5dc34f2fdcac5c219fe4d50dda3902bdc57e38e9ef50d42b74cb6961463
  Migrations: 0xaaf17169c4a2a6b3b6025510ac6e236923c1e1f7
Saving successful migration to network...
  ... 0x963dfb92bf28e70ade200d8b542e56139b6dd78b199b62409f38fa1f4e0fdf9b
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying Election...
  ... 0x8482e1e43b5a229420e3c375a6ec05e2686ecfd746fe964d45b3c6288f1eae0a
  Election: 0x6189e09fe1d18627d417e573d1e734fd5e8cd1ac
Saving successful migration to network...
  ... 0xa59dcd814c9517b20c7c3d45588c01e0291bb8cae881bf0742085741fad1a85b
Saving artifacts...
-> deploy


Check in console:
----------------
Election.deployed().then(function(instance){ app = instance }) -> actual it returns the promise its asynchronous nature of smart contract development
-> here .then function executes on promise and returns the result once it is executed
app.candidate() -> note this is not a variable but its a function we got this getter function from soliditity for declaring a variable as public and we don't need to declarate of this function

-> If you check the ganache, Balance is increased by 0.05 eth, 
It means whatever we deploy the contract to blockchain its going to cost ethereum, and in our development environment it going to debt the amount from first account of ethereum, since we defined to debt from last tx

Changing the version of solidity from 0.4.11 to 0.4.2 which has truffle support 

List Candidates
---------------
For that we need 

- modal a candidate
- store candidates
- fetch candidate
- store candidates count 

-- refer to election.sol file for details

- mappining in solidity is an associative array or hash mapping(uint => Candidate)
- here key will be unisigned integer, which responds to candidate ID
- and value should be candidate structure type, this is the way we store our candidates
- during smoke test we can declare this mapping as public and solidity will generate a candidates function for us, which is getter methods candidates(), this fn 
- is enterly designed to return all the mapping
- mapping(uint => candidate) public Candidates;
  -  which allows us to fetch our candidates from mapping
- whenever we add a candidate to this mapping we are changing the state of our contract and writing to blockchain, this is the way where we persists our candidates and store
- this mapping will interact the datalayer of blockchain 
- Using CamelCase we can store the candidates count - why camelCase? - 
- In solidilty there is no way where we can define the size of a mapping and there is no way to iterate over either 
- this count will help us to know how many candidates are available in mapping, this helps us to access each of candidate without mapping inside loop
- For this we need to addcandidate refer election.sol 

Lets read the value from console
-------------------
For this we must ensure that our local blockchain is running, Ganache 
- and we also want to migrate our contract 
  - truffle migrate --reset
- reset flag-> all of the code in blockchain is immutable, in development if we want to reflect ur changes we use reset flag where it drops all our migration tables, data, creates a new copy and new address. Since we are not suppose to change the code in blockchain  

Lets open a console and get instance of contract deployed in blockchain 

- Election.deployed().then(function(i) {app = i });
- app.candidates();
  - Error: Invalid number of arguments to Solidity function

- app.candidates(1), app.candidate(2)
- app.candidates(1).then(function(i) {candidate = i}); -> declares var using promise
- candidate.id -> undefined cannot be accessed like this, since we define our candidate as struct, but structs in solidity are suntactic sugar, but ethereum virtual machine is not really aware of them 
- EVM doesn't know how to contruct the values when we define a mapping, so it will contruct as [Bignumber {s:10, e:0. c:[0]}, candidate, BigNumber{s:0, e:0, c:[1]}]
- we can access all our values by 0 based index, candidate[0] -> which returns the id, candidate[1]-> returns name, candidate[2] -> returns votecount
- we can convert bignumber to integer by candidate[0].toNumber()

Importance of Testing the contract
------
- since it cost ethereum when we deploy 
- blockchain is immutable
- everytime when we deploy it will create a new copy and address it will changes the current state 
- And it should be bug free when we deploy to make sure to meet all the above points we need to write test and make sure its bug free
