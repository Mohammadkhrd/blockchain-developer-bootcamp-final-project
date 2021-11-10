// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Lottery is Ownable {

    enum LotteryStatus {
        open,
        close
    }
    LotteryStatus lotteryStatus;

    enum UserStatus {
        notDeposited,
        deposited
    }
    UserStatus userStatus;

    event Deposit(address player , uint value);
    event WithdrawMoney(address winner , uint value);

    mapping(uint => address) public Players;
    mapping(address => UserStatus) private _eligibile;
    uint playerId;
    constructor() {
         playerId = 0;
    }
    function deposit() public payable {   
        
        require (lotteryStatus == LotteryStatus.open);
        require(_eligibile[msg.sender] == UserStatus.notDeposited);
        require (msg.value == 1 ether);

        playerId += 1;
        Players[playerId] = msg.sender;
        _eligibile[msg.sender] = UserStatus.deposited;

        emit Deposit(msg.sender,msg.value);
    }
    function _random() private view returns (uint) {
        return (uint(keccak256(abi.encodePacked(block.timestamp , block.difficulty , msg.sender))) % playerId) + 1;
    }
     function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    function withdrawMoney() public onlyOwner {
        
        uint winnerId = _random();
        address payable to = payable (Players[winnerId]);
        
        uint contractBalance = getBalance();
        to.transfer(contractBalance);

        lotteryStatus = LotteryStatus.close;
        
        emit WithdrawMoney(to , contractBalance);
    }
    function reOpenLottery() public onlyOwner {
        lotteryStatus = LotteryStatus.open;
        playerId = 0;
    }   
}