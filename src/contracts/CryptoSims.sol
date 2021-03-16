pragma solidity 0.5.0;

import "./ERC721Full.sol";

contract CryptoSims is ERC721 {


  mapping(string => bool) _botNameExists;
  
   mapping (uint => address payable) public monstersIndexToAddress;
    
   address payable public owner;// address is payable
   uint256 public totalSupply;
  string public name;
    string public symbol;
    uint8 public decimals;
    
    
 uint256 public claimFirst100 = 0.05 ether;// 0.05 ether; //at 10$
  uint256 public claimFirst900 = 0.1 ether; // 0.1 ether; //at $20
  uint256 public claimFirst9k = 0.5 ether;//0.5 ether; //at $100
  
    uint256 public claimFirst20k = 5 ether; //set to 8 bnb
    uint256 public claimFirst30k = 20 ether; //set to 8 bnb
    uint256 public claimFirst40k = 100 ether; //set to 8 bnb
     uint256 public claimFirst50k = 500 ether; //set to 8 bnb
    uint256 public claimFirst60k = 2000 ether; //set to 8 bnb
     uint256 public claimFirst70k = 10000 ether; //set to 8 bnb
    uint256 public claimFirst80k = 50000 ether; //set to 8 bnb
    uint256 public claimFirst90k = 200000 ether; //set to 8 bnb
      uint256 public claimlast10k = 1000000 ether; //set to 8 bnb
    
   
     uint maxSims = 100000; //100k
      uint256 public claimPrice = 0.5 ether; //set to 8 bnb
          uint256 public changeItemPrice = 1.0 ether; //1 bnb to change features 
         
          uint256 public changePrice = .0003 ether;// $1 to change secret for owners
          uint256 public likesPrice = 0.0001 ether; //set to $1
 uint256 public secretPrice = 1 ether; //1 bnb to change others secter cents;
     uint public id ;
      simWearables[] public sims; //sim wearables
 Digitmon[] public digitmon; // where all sims go 
 uint level;
 uint health;
 string weapon;
  address payable public user;
 
 
 struct simWearables{  // items people can buy for their sims/ can be place within block
       uint a;
       uint b;
       uint c;
       uint d;
     address payable originalOwner;
       
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

     //string sale;
     //uint price;
      
      // uint cordX;
     //  uint cordY;
       
      
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



  //only creater makes people
  function mint(string memory _name, string memory _gender, string memory _haircolor, string memory _eyecolor, string memory _headcolor, string memory _secret) public payable {
  require( totalSupply <= maxSims);// 100k sims can only be created
     
    require(!_botNameExists[_name]);
     id = digitmon.length;
     digitmon.push(Digitmon(_name, _gender, _haircolor, _eyecolor, _headcolor, _secret,1, msg.sender));
     sims.push(simWearables(0,0,0,0, msg.sender));
   _mint(msg.sender, id);//create them but dont mint here
   
    totalSupply++;//update total supply
    monstersIndexToAddress[id] = msg.sender;//put address of minter inside here
    _botNameExists[_name] = true;

     // require(msg.sender == owner) ; 
     if(totalSupply <= 100){
          require(msg.value ==  claimFirst100 || msg.value >=  claimFirst100 );  
           owner.transfer(claimFirst100);
     }
     if(totalSupply <= 900 && totalSupply > 100 ){
        require(msg.value == claimFirst900 || msg.value >= claimFirst900 );  
        owner.transfer(claimFirst900);
     }
      if(totalSupply <= 9000 && totalSupply > 900){
        require(msg.value == claimFirst9k || msg.value >= claimFirst9k );  //first 10k
        owner.transfer(claimFirst9k);
     }
     
     
       if(totalSupply <= 20000 && totalSupply > 9000){
        require(msg.value == claimFirst20k || msg.value >= claimFirst20k );  
        owner.transfer(claimFirst20k);
     }
      if(totalSupply <= 30000  && totalSupply > 20000){
        require(msg.value == claimFirst30k || msg.value >= claimFirst30k );  
        owner.transfer(claimFirst30k);
     }
       if(totalSupply <= 40000 && totalSupply > 30000){
        require(msg.value == claimFirst40k || msg.value >= claimFirst40k );  
        owner.transfer(claimFirst40k);
     }
      if(totalSupply <= 50000 && totalSupply > 40000){
        require(msg.value == claimFirst50k || msg.value >= claimFirst50k );  
        owner.transfer(claimFirst50k);
     }
       if(totalSupply <= 60000 && totalSupply > 50000){
        require(msg.value == claimFirst60k || msg.value >= claimFirst60k );  
        owner.transfer(claimFirst60k);
     }
      if(totalSupply <= 70000 && totalSupply > 60000){
        require(msg.value == claimFirst70k || msg.value >= claimFirst70k ); 
        owner.transfer(claimFirst70k);
     }
       if(totalSupply <= 80000&& totalSupply > 70000){
        require(msg.value == claimFirst80k || msg.value >= claimFirst80k );  
        owner.transfer(claimFirst80k);
     }
      if(totalSupply <= 90000 && totalSupply > 80000){
        require(msg.value == claimFirst90k || msg.value >= claimFirst90k ); 
        owner.transfer(claimFirst90k);
     }
     
      if(totalSupply <= 100000 && totalSupply > 90000){
        require(msg.value == claimlast10k || msg.value >= claimlast10k ); 
        owner.transfer(claimlast10k);
        
     }
     
     
     
     
   
    
   // 
    // owner.transfer(claimFirst900);
    // owner.transfer(claimFirst9k);
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

 //make payable change sim internall address if you bought it from sombody else to recieve like royalties
     function changeSimOwnerAddress(uint _id) public payable{
         // require(msg.value == changePrice || msg.value >= changePrice); 
            
       require(monstersIndexToAddress[_id] == msg.sender);//check if address of sender is equal to the id
        Digitmon  storage userDigitMon = digitmon[_id];
        
        
        userDigitMon.simowner = msg.sender;
       
         
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
           require(msg.value == likesPrice || msg.value >= likesPrice);
      // require(monstersIndexToAddress[_id+3] == msg.sender);//
      Digitmon  storage userDigitMon = digitmon[_id];
     // simWearables  storage usersim = sims[_id];
    if(monstersIndexToAddress[_id] == msg.sender){
         userDigitMon.likes += 0; 
    }else{
          userDigitMon.likes += 10;
    }
        //give share to users
       // user = monstersIndexToAddress[_id] ;dnt need
     
      
       
       userDigitMon.simowner.transfer(likesPrice/2);// give to current owner
       
      
       owner.transfer(address(this).balance);
       
  }
  
  
  
    //change others secret , add an add for a price , sim owner gets royalties /2
     function changeOthersSecret(uint _id, string memory _secret) public payable{
           require(msg.value == secretPrice || msg.value >= secretPrice);
      // require(monstersIndexToAddress[_id+3] == msg.sender);//
      Digitmon  storage userDigitMon = digitmon[_id];
      userDigitMon.secret = _secret;
        //give share to users
       // user = monstersIndexToAddress[_id] ;dnt need
       userDigitMon.simowner.transfer(secretPrice/2);
       owner.transfer(address(this).balance);
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



 


  
    //This function will return all born creatures
    function withdrawGds()public payable{
        
       // return  digitmon.length ;
      //  uint256 ss = address.this.balance;
           owner.transfer(address(this).balance);
    }
    
  
  
  
  
  
   


  
   
}