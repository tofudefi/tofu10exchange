pragma solidity ^0.5.0;

import "./Ownable.sol";
import "./IERC20.sol";
import "./SafeMath.sol";


contract Tofu10Exchange is Ownable {

    using SafeMath for uint256;

    IERC20 private _tofu20;
    trcToken tofu10id = 1003475;

    constructor (IERC20 t20) public  {
        _tofu20 = t20; 
    }


    function exchange10to20() payable public returns (bool)  {
        require(msg.tokenid == tofu10id, "Only TOFU10 is allowed");
        require(msg.tokenvalue > 0, "Invalid amount");
        return _tofu20.transfer(msg.sender, msg.tokenvalue);
    }

    function exchange20to10(uint256 amount) public returns (bool)  {
        _tofu20.transferFrom(msg.sender, address(this), amount);
        msg.sender.transferToken(amount, tofu10id);
        return true;
    }


    function withdrawTRC10(address payable toAddress, uint256 tokenValue, trcToken id) public onlyOwner  {
        toAddress.transferToken(tokenValue, id);
    }   

    function withdrawTRX(address payable toAddress, uint256 value) public onlyOwner  {
        toAddress.transfer(value);
    }  

}


