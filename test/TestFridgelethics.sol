pragma solidity ^0.4.19;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Fridgelethics.sol";

contract TestFridgelethics {

  function testInitialBalanceUsingDeployedContract() public {
    Fridgelethics fridge = new Fridgelethics();

    Assert.equal(fridge.totalSupply(), 0, "No tokens should exist!");
  }
}
