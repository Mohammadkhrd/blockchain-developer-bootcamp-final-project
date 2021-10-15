// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract Lottery {

    address public owner;

    enum LotteryStatus {
        open,
        close
    }

    LotteryStatus lotteryStatus;

    event Deposit(address player , uint value );
    event WithdrawMoney(address winner , uint value);

    uint playerId = 0;
    mapping(uint => address) public Players;

    constructor() {
        owner = msg.sender;
    }


    function deposit() public payable {   
        

        require (lotteryStatus == LotteryStatus.open);
        require (msg.value == 1 ether);
        playerId += 1;
        
        Players[playerId] = msg.sender;
        emit Deposit(msg.sender,msg.value);

    }

    function random() private view returns (uint) {

        return uint(keccak256(abi.encodePacked(block.timestamp , block.difficulty , msg.sender))) % playerId;

    }
    
     function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    
    function withdrawMoney() public {
        require(msg.sender == owner);

        address payable to = payable (Players[playerId]);
        uint contractBalance = getBalance();
        to.transfer(contractBalance);

        lotteryStatus = LotteryStatus.close;
        emit WithdrawMoney(to , contractBalance);

    }

    function reOpenLottery() public {
        require(msg.sender == owner);
        lotteryStatus = LotteryStatus.open;
    }
    
}