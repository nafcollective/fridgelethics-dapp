pragma solidity ^0.4.24;

import "./BasicToken.sol";
import "./Ownable.sol";


/**
 * @title Mintable token
 * @dev Simple ERC20 Token example, with mintable token creation
 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
 */
contract Fridgelethics is BasicToken, Ownable {
  event Mint(address indexed to, uint256 amount);
  event Claim(address to, uint256 value);


  modifier hasMintPermission() {
    require(msg.sender == owner);
    _;
  }

  modifier hasSentEth() {
    require(msg.value > 0);
    _;
  }

    /**
   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address _to, uint256 _amount) hasMintPermission public returns (bool) {
    totalSupply_ = totalSupply_.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    emit Mint(_to, _amount);
    emit Transfer(address(0), _to, _amount);
    return true;
  }

  /**
  @dev Function to claim tokens
  */
  function claim() hasSentEth public payable {
    owner.transfer(msg.value);
    emit Claim(msg.sender, msg.value);
  }

}
