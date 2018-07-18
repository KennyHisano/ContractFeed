// @title Access control for authorized members.
// @author Kenny Hisano(https://github.com/KennyHisano)


pragma solidity ^0.4.11;

contract AccessControl {
    
    /** this contract is responsible for granting priviledge access to the 
     *  owners of generated token. The level of access priviledge shall be
     *  cosidered carefully.
     */
     
   
    //@dev address identified with each owner 
    address public ownerAddress;
    
    
    
    // @dev Keeps track whether the contract is paused. When that is true, most actions are blocked
    bool public paused = false;
    
    
    
    // @dev Access modifier for owner-only functionality
    modifier onlyOwner() {
        require(msg.sender == ownerAddress);
        _;
    }


    // @dev Assigns a new address to act as the owner. Only available to the current owner.
    // @param _newOwner The address of the new owner
    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0));

        ownerAddress = _newOwner;
    }
    
    
    
     /*** Pausable functionality adapted from OpenZeppelin ***/

    // @dev Modifier to allow actions only when the contract IS NOT paused
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    // @dev Modifier to allow actions only when the contract IS paused
    modifier whenPaused {
        require(paused);
        _;
    }

    // @dev Unpauses the smart contract. Can only be called by the Owner, since
    // @notice This is public rather than external so it can be called by
    //  derived contracts.
    function unpause() public onlyOwner whenPaused {
        // can't unpause if contract was upgraded
        paused = false;
    }


    
}