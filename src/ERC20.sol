// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Token1 is ERC20 {
    uint256 public number;

    constructor() ERC20("StableCoin1", "SC1") {
        _mint(msg.sender, 1000000000000000000000000000);
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }


contract Token2 is ERC20 {
    uint256 public number;

    constructor() ERC20("Token2", "TK2") {
        _mint(msg.sender, 1000000000000000000000000000);
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }}
}