// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.16 <0.9.0;

contract Subcurrency{
//state variables
    address public minter;
    mapping(address=>uint) public balances;

//error functions
error insufficentBalance(uint requested,uint available);

//modifiers
modifier onlyMinter(){
    require(msg.sender == minter,"only minter can call this function!");
    _;
}

//eventsz
event sent(address from,address to,uint amount);

//constructors
constructor(){
    minter = msg.sender;
}

//functions
    function mint(address receiver,uint amount)
    public 
    onlyMinter{
        balances[receiver] += amount;
    }
    function send(address receiver,uint amount)
    public
    {
        if(amount>balances[msg.sender])
        revert("insufficent balance!");
        balances[msg.sender] -= amount;
        balances[receiver]+=amount;
        emit sent(msg.sender,receiver,amount);
    }
}
