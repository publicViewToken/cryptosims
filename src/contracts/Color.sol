pragma solidity 0.5.0;

import "./erc721full.sol";

contract Color is ERC721 {


  mapping(string => bool) _botNameExists;
  
   mapping (uint => address) public monstersIndexToAddress;
    
   address payable public owner;// address is payable
   uint256 public totalSupply;
  string public name;
    string public symbol;
    uint8 public decimals;
  uint256 public claimPrice = 0.03 ether; //8-10$ at time of coding swutch to bnb prices whe on bnb
          uint256 public changeItemPrice = 0.3 ether; //80 cnets
         
          uint256 public changePrice = 0.0003 ether;// 10 cent
          uint256 public likesPrice = 0.0001 ether; //3 cents;

     uint public id ;
      simWearables[] public sims; //sim wearables
 Digitmon[] public digitmon; // where all sims go 
 uint level;
 uint health;
 string weapon;
 
 struct simWearables{  // items people can buy for their sims/ can be place within block
       uint a;
       uint b;
       uint c;
       uint d;
       
       
   }
 

 struct Digitmon{   //all the sims
     
         string name; //mintabel
        string gender;
        string hairColor;
        string eyeColor;
       string  headColor;
       string secret;
       uint likes;
      address payable simowner;

    
    
       
      
 }
 
   constructor() public
   {
       owner = msg.sender;
      name = "Crypto Sims";                          // Set the name for display purposes
       symbol = "SIMS";                               // Set the symbol for display purposes
       decimals = 0; 
    }
    
    
 // constructor() ERC721Full("Crypto Sims", "SIMS") public {
         
 // }

 uint maxSims = 100000; //100k

  //only creater makes people
  function mint(string memory _name, string memory _gender, string memory _haircolor, string memory _eyecolor, string memory _headcolor, string memory _secret) public payable {
  require( totalSupply <= maxSims);// 100k sims can only be created
    require(!_botNameExists[_name]);
     // require(msg.sender == owner) ; 
    require(msg.value == claimPrice || msg.value >= claimPrice );  
   id = digitmon.length;
    digitmon.push(Digitmon(_name, _gender, _haircolor, _eyecolor, _headcolor, _secret,1, msg.sender));
     sims.push(simWearables(0,0,0,0));
   _mint(msg.sender, id);//create them but dont mint here
   
    totalSupply += digitmon.length;//update total supply
    monstersIndexToAddress[id] = msg.sender;//put address of minter inside here
    _botNameExists[_name] = true;
     owner.transfer(claimPrice );
  }
  
  //make payable
     function changeName(uint _id, string memory _name) public payable{
          require(msg.value == changePrice || msg.value >= changePrice); 
            
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        Digitmon  storage userDigitMon = digitmon[_id];
         _botNameExists[userDigitMon.name] = false;// remove old name so others can use it 
        
        userDigitMon.name = _name;
        _botNameExists[_name] = true;// re add new name
          owner.transfer(changeItemPrice );
  }


    //make payable
     function changeGender(uint _id, string memory _g) public payable{
          require(msg.value == changeItemPrice); 
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        Digitmon  storage userDigitMon = digitmon[_id];
        userDigitMon.gender = _g;
          owner.transfer(changeItemPrice );
        
  }

//make payable
     function changeHair(uint _id, string memory _h) public payable{
          require(msg.value == changeItemPrice); 
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        Digitmon  storage userDigitMon = digitmon[_id];
        userDigitMon.hairColor = _h;
          owner.transfer(changeItemPrice );
  }

//make payable
     function changeEye(uint _id, string memory _e) public payable{
          require(msg.value == changeItemPrice); 
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        Digitmon  storage userDigitMon = digitmon[_id];
        userDigitMon.eyeColor = _e;
        owner.transfer(changeItemPrice );
  }
  
  //make payable
     function changeHead(uint _id, string memory _headcolor) public payable{
          require(msg.value == changeItemPrice); 
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        Digitmon  storage userDigitMon = digitmon[_id];
        userDigitMon.headColor = _headcolor;
        owner.transfer(changeItemPrice );
  }


 
  //make payable
     function changeSecret(uint _id, string memory _secret) public payable{
            require(msg.value == changePrice || msg.value >= changePrice); 
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        Digitmon  storage userDigitMon = digitmon[_id];
        userDigitMon.secret = _secret;
        owner.transfer(changePrice );
  }


  //make payable
     function giveLike(uint _id) public payable{
           require(msg.value == changePrice || msg.value >= changePrice);
      // require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        Digitmon  storage userDigitMon = digitmon[_id];
        userDigitMon.likes += 1;
        owner.transfer(likesPrice);
  }



  //make payable
     function equipA(uint _id) public payable{
          require(msg.value >= changeItemPrice || msg.value == changeItemPrice); 
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        simWearables  storage simbag = sims[_id];
        simbag.a += 1;
        owner.transfer(changeItemPrice);
  }

  //make payable
     function equipB(uint _id) public payable{
            require(msg.value >= changeItemPrice || msg.value == changeItemPrice);  
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        simWearables  storage simbag = sims[_id];
        simbag.b += 1;
        owner.transfer(changeItemPrice);
  }

//make payable
     function equipC(uint _id) public payable{
          require(msg.value >= changeItemPrice || msg.value == changeItemPrice);  
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        simWearables  storage simbag = sims[_id];
        simbag.c += 1;
        owner.transfer(changeItemPrice);
  }

  
  //make payable
     function equipD(uint _id) public payable{
           require(msg.value >= changeItemPrice || msg.value == changeItemPrice); 
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        simWearables  storage simbag = sims[_id];
        simbag.d += 1;
        owner.transfer(changeItemPrice);
  }

  
  
  
  
  
  
    // train your bot
    function Train_Digimon(uint _id) public {
       //require(msg.value != claimPrice) ;  
       
    require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
    
    
    Digitmon  storage userDigitMon = digitmon[_id];
     
    //  userDigitMon.level += 1;
     //  userDigitMon.health += 110;
      //  userDigitMon.powerLevel += 110;
        //check levels can train and grow levels until level 50
     //   if(userDigitMon.level == 5){
      //      userDigitMon.weapon = "Plasma Ray";
      /////  }
       // if(userDigitMon.level == 10){
        //    userDigitMon.weapon = "Crystal Suit";
      //  }
       
       
    //  owner.transfer(claimPrice);
         // DigitMon.digitmon[].level++;
        
          
    }
  


  
   
}