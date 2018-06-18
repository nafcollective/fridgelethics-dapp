pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Fridgelethics.sol";

contract TestFridgelethics {
  uint public initialBalance = 1 ether;
  Fridgelethics fridge;
  Address backend;
  Address runner;

  function beforeEach() public {
    fridge = new Fridgelethics();
    backend = new Address();
    runner = new Address();
  }

  function testContractOwnership() public {
    Assert.equal(fridge.owner(), this, "The owner should be equal to the deployer");
  }

  function testClaiming() public {
    address(runner).transfer(10 finney);
    runner.claim(fridge, 5 finney);
    uint expected = initialBalance - 5 finney;

    Assert.equal(address(this).balance, expected, "The owner should have received 10 finney");
  }

  function testMinting() public {
    fridge.transferOwnership(address(backend));
    backend.mint(fridge, address(runner), 1);

    Assert.equal(fridge.balanceOf(address(runner)), 1, "Runner should posses 1 Fridgelethiccoins");
    Assert.equal(fridge.totalSupply(), 1, "Total supply should have increased by 1 Token");
  }

  function() public payable { }
}

contract Address {
  function() public payable { }

  function claim(Fridgelethics _fridge, uint256 _amount) public payable {
    _fridge.claim.value(_amount)();
  }

  function mint(Fridgelethics _fridge, address _to, uint256 _amount) public payable {
    _fridge.mint(_to, _amount);
  }
}
