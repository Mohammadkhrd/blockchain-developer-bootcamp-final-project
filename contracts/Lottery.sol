pragma solidity ^0.8.0;

contract Lottery {

    address public admin;
    address[] public players;

    enum LotteryStatus {
        open,
        close
    }

    LotteryStatus lotteryStatus;

    event Deposit(address player , uint value );
    event WithdrawMoney(address winner , uint value);

    constructor() {
        admin = msg.sender;
    }

    function deposit() public payable {   

        require (lotteryStatus == LotteryStatus.open);
        require (msg.value == 1 ether);
        
        players.push(msg.sender);

        emit Deposit(msg.sender,msg.value);

    }

    function random() private view returns (uint) {

        return uint(keccak256(abi.encodePacked(block.timestamp , block.difficulty , msg.sender))) % players.length;

    }
    
     function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    
    function withdrawMoney() public {
        require(msg.sender == admin);

        address payable to = payable(players[random()]);
        uint contractBalance = getBalance();
        to.transfer(contractBalance);

        lotteryStatus = LotteryStatus.close;
        emit WithdrawMoney(to , contractBalance);

    }
    
}