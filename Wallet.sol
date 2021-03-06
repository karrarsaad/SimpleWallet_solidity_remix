pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
//Shared Wallet with Allowance Function

contract Allowance is Ownable{
 
using SafeMath for uint;

 event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);

 mapping(address => uint) public allowance;
 
 function addAllowance(address _who, uint _amount) public onlyOwner {
   emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
 allowance[_who] = _amount;
 }
 
 modifier ownerOrAllowed(uint _amount) {
 require(msg.sender == owner() || allowance[msg.sender] >= _amount, "You are not allowed!");
 _;
 }
 
function reduceAllowance(address _who, uint _amount) public ownerOrAllowed(_amount) {
  emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));

 allowance[_who] = allowance[_who].sub(_amount);
 }

 event MoneyReceived(address indexed _from, uint _amount);

 receive() external payable {
 emit MoneyReceived(msg.sender, msg.value);
 }

 function renounceOwnership() view public override onlyOwner {
 revert("can't renounceOwnership here"); //not possible with this smart contract
 }

 event MoneySent(address indexed _beneficiary, uint _amount);

 function withdrawMoney (address payable _to, uint _amount) public  ownerOrAllowed(_amount)   {
   require(_amount <= address(this).balance, "Contract doesn't own enough money");
   if(msg.sender != owner()) {
   reduceAllowance(msg.sender, _amount);
 }
  emit MoneySent(_to, _amount);

 _to.transfer(_amount);
 }
 

}









//////////////////////
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
// //Shared Wallet with Allowance Function

// contract Allowance is Ownable{
 
// //  receive() external payable {
 
// //  }

//  event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);

//  mapping(address => uint) public allowance;
 
//  function addAllowance(address _who, uint _amount) public onlyOwner {
//    emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
//  allowance[_who] = _amount;
//  }
 
//  modifier ownerOrAllowed(uint _amount) {
//  require(msg.sender == owner() || allowance[msg.sender] >= _amount, "You are not allowed!");
//  _;
//  }
 
// function reduceAllowance(address _who, uint _amount) public ownerOrAllowed(_amount) {
//   emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);

//  allowance[_who] -= _amount;
//  }

//  event MoneyReceived(address indexed _from, uint _amount);
//  receive() external payable {
//  emit MoneyReceived(msg.sender, msg.value);
//  }

//  event MoneySent(address indexed _beneficiary, uint _amount);

//  function withdrawMoney (address payable _to, uint _amount) public  ownerOrAllowed(_amount)   {
//    require(_amount <= address(this).balance, "Contract doesn't own enough money");
//    if(msg.sender != owner()) {
//    reduceAllowance(msg.sender, _amount);
//  }
//   emit MoneySent(_to, _amount);

//  _to.transfer(_amount);
//  }
 

// }



// contract SharedWallet is Allowance{

// event MoneySent(address indexed _beneficiary, uint _amount);

//  function withdrawMoney (address payable _to, uint _amount) public  ownerOrAllowed(_amount)   {
//    require(_amount <= address(this).balance, "Contract doesn't own enough money");
//    if(msg.sender != owner()) {
//    reduceAllowance(msg.sender, _amount);
//  }
//   emit MoneySent(_to, _amount);

//  _to.transfer(_amount);
//  }
 
// }







////////
// contract SharedWallet is Ownable {
 

// //  address public owner;
 
// //  constructor()  {
// //  owner = msg.sender;
// //  }
 
// //  modifier onlyOwner() {
// //  require(msg.sender == owner, "You are not allowed");
// //  _;
// //  }

//  function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
//  _to.transfer(_amount);
//  }
 
//  receive () external payable {
 
//  }
// }


