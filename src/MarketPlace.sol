// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "./Swap.sol";

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract MarketPlace {
    address public SC1Address = address(0x5eB7c71f8c388Ef027e35A0ADb30a555f2F9752a);
    address public TK2Address = address(0xBb79Ce7A1C5C9606eeFdeF4050d7fD67Ac3dB4f0);

    AggregatorV3Interface internal dataFeed;

    uint public tk2Price = 0;

    constructor(address _sc1Address, address _tk2Address) {
        SC1Address = _sc1Address;
        TK2Address = _tk2Address;
        dataFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
    }

    function getTK2Price() public returns (uint) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = dataFeed.latestRoundData();
        tk2Price = uint(price);
        return tk2Price;
    }

    function swapTok1ForTok2(uint sc1Amount) public {
        uint _tk2Price = getTK2Price();
        require(_tk2Price > 0, "Invalid price");
        uint tk2Amount = (sc1Amount * 10 ** 8) / _tk2Price;

        require(
            IERC20(SC1Address).allowance(msg.sender, address(this)) >=
                sc1Amount,
            "Not enough allowance"
        );
        require(
            IERC20(SC1Address).transferFrom(
                msg.sender,
                address(this),
                sc1Amount
            ),
            "Transfer failed"
        );
        IERC20(TK2Address).transfer(msg.sender, tk2Amount);
    }

    function swapTok2ForTok1(uint tk2Amount) public {
        uint _tk2Price = getTK2Price();
        require(_tk2Price > 0, "Invalid price");
        uint sc1Amount = (tk2Amount * _tk2Price) / 10 ** 8;

        require(
            IERC20(TK2Address).allowance(msg.sender, address(this)) >=
                tk2Amount,
            "Not enough allowance"
        );

        require(
            IERC20(TK2Address).transferFrom(
                msg.sender,
                address(this),
                tk2Amount
            ),
            "Transfer failed"
        );
        IERC20(SC1Address).transfer(msg.sender, sc1Amount);
    }
}