pragma solidity ^0.4.11;

// #1.declare a contract
// first create the smoke test to ensure we setup everything correctly, that going to deploy and that going to respond to 
// we need constructor, 1a set the candidate name
// -- contract Election {
//   // Strore candidate
//   // Read candidate
//   --string public candidate;
//   // Constructor, we are define the constructor as same name as contracter, 
//   // constructor is going to run on blockchain whenever we deploy our constructor blockchain, for that reason we need to declare it as public
//   // by defining variable as stake variable we can read/write 
  
//   --function Election () public {
//     // store the value of candidate by setting the value of candidate
//     --candidate = "Candidate 1"; //without underscore before a var defines the stake variable - are something that going to be accessible inside of the contract and represents the data belongs to entire contract

//   --}

// --}

contract Election {
  // Modal a candidate
  struct Candidate{
    uint id;
    string name;
    uint voterCount;
  }

  // store accounts that have voted
  mapping(address => bool) public voters;

  // Store candidates
  // Fetch a candidate
  // here Candidate as value defines structure of candidate
  mapping(uint => Candidate) public candidates;
  // store candidates count 
  // stores the candidates count which helps in iterate over loop
  uint public candidatesCount;

  // voted event 
  event votedEvent (
    
  );
  
  function Election () public {
    // we call the addfn inside the constructor, this will run whenever our contract is migrated and deployed
    addCandidate("Candidate 1");
    addCandidate("Candidate 2");
    // Now we added candidates to our smart contract
    // after deploy we store these candidates into our mapping with key as unsigned integer ofcourse bonds to candidates ID 
  }

  // here we are defining the addCandidate fn which accepts name as input and which is local variable so it is added with '_'
  // we make this fn as private we don't want this fn to accessed by public interface, we want only contract to add this candidate 
  function addCandidate (string _name) private {
    candidatesCount++;
    //we are creating a candidate by referencing the candidates defined in mapping 
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }

  function vote (uint _candidateId) public {
    // require that they vote only once
    require(!voters[msg.sender]);

    // require to make sure only valid candidates vote
    require(_candidateId > 0 && _candidateId <= candidatesCount);

    // record that voter has voterID
    voters[msg.sender] = true;
    //update vote count 
    candidates[_candidateId].voterCount ++;
  }

}















