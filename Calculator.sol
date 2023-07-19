 //SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";



contract calculator{
    uint8 public a = 5;
    uint8 public b = 10;
    uint minAmount = 1 ether;
    address   public owner;

    event Transfer(uint amount,uint balance );

     constructor() {
        owner = (msg.sender); 
        }

     modifier onlyOwner(){
        require(msg.sender == owner,"Not owner");
        _;
        }

     using SafeMath for uint8;

     function store(uint8 _a) public virtual{
             a = _a;
             } 

     function store2 (uint8 _b) public virtual{
             b = _b;
             } 


     function add() external view returns(uint8){
         require(b > 0, "Error: b must be greater than 0");
          return a + b;
          }

     function transfermultiply() payable external onlyOwner returns(uint8 ) {
         require(msg.value >= minAmount, "No min ether provided");
         payable(address(this)).transfer(msg.value); //here it is inbuit transfer key word
         emit Transfer(1 ether,address(this).balance);
         return  a * b ;
        }

     function transferpower() payable external onlyOwner returns(uint8 ) {
         require(msg.value >= minAmount, "No min ether provided");
         payable(address(this)).transfer(msg.value); //here it is inbuit transfer key word
         emit Transfer(1 ether,address(this).balance);
         return  a ** b ;
        }

     function sub() external view returns(uint8){
         require(b > 0, "Error: b must be greater than 0");
         return a - b;
          
    }

     function div() external onlyOwner view returns(uint8) {
         require(b > 0, "Error: b must be greater than 0");
         return a / b;
         }

     function mod() external  onlyOwner view returns(uint8) {
     return a % b  ;
      }
  
     function generateRandomNumber() public view returns (bytes32) {
     uint256 timestamp = block.timestamp;
     bytes32 hash = keccak256(abi.encodePacked(timestamp));
     return hash;
     }


}