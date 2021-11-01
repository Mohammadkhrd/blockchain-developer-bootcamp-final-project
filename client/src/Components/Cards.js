function Cards() {
    return (
        <div class="ui card" style={{position: 'absolute', left: '50%', top: '50%', transform: 'translate(-50%, -50%)'}}>
            <div class="content">
                <div class="header">Contract ETH Balance :</div>
                  <div class="meta">User</div>
                    <div class="description" style={{fontSize: '15px'}}>
                        To participate in this lottery , you need to deposit one ETH . one ETH = one ticket
                        <div className={"n"}>
                            </div><strong>Notice :</strong> For decentralizition , everyone can buy only one ticket and if you participate in one lottery , you can't do it again
                       </div>
            </div>

                <div class="extra content">
                    <div class="ui two buttons">
                       <button class="ui green basic button">Buy Lottery Ticket</button>
                    </div>
                </div>
        </div>
    )
}

export default Cards
