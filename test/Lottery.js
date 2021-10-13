const Lottery = artifacts.require("Lottery");


contract('Lottery', async (accounts) => {
    let lottery;

    before(async () => {
        lottery = await Lottery.deployed();
    })

    // No one deposit ETH to the contract , so Lottery Contract balance should be 0;
    it('Lottery balance should starts with 0 ETH', async () => {
        let balance = await lottery.getBalance();
        assert.equal(balance, 0);
    })

    // function deposit() public payable {}
    it('Lottery balance should has 1 ETH after deposit', async () => {
        await lottery.deposit({from: accounts[1], value: 1000000000000000000});
        let balance = await lottery.getBalance()
        assert.equal(balance , 1000000000000000000);
    })

    // function deposit() public payable {}
    it('Lottery balance should has 2 ETH after deposit', async () => {
        await lottery.deposit({from: accounts[2], value: 1000000000000000000});
        let balance = await lottery.getBalance()
        assert.equal(balance , 2000000000000000000);
    })
    
    // require (msg.value == 1 ether);
    it('User cant send more or less than one ETH', async () => {

        try {
            await lottery.deposit({from: accounts[3], value: 3000000000000000000});
        } 
        catch(err) {  
            let balance = await lottery.getBalance()
            assert.equal (balance , 2000000000000000000)
        }
    })

    // function withdrawMoney() public {}
    it('Lottery balance should has 0 ETH after withdraw ', async () => {
        await lottery.withdrawMoney();
        let balance = await lottery.getBalance()
        assert.equal(balance , 0000000000000000000);
    })

    // for any deposit require (lotteryStatus == LotteryStatus.open); after withdrawMoney function (lotteryStatus = LotteryStatus.close);
    it('Lottery should be close (users cant send any ETH)', async () => {

        try {
            await lottery.deposit({from: accounts[3], value: 1000000000000000000});
        } 
        catch(err) {  
            let balance = await lottery.getBalance();
            assert.equal (balance , 0000000000000000000)
        }

    })

})



