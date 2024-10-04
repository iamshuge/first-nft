// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {Test, console2} from "forge-std/Test.sol";

contract BasicNftTest is Test {
    string constant NFT_NAME = "Dogie";
    string constant NFT_SYMBOL = "DOG";

    address public constant USER = address(1);
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    BasicNft public basicNft;
    DeployBasicNft public deployer;
    address public deployerAddress;

        function setUp() public {
        // if (!isZkSyncChain()) {
        //     deployer = new DeployBasicNft();
        //     basicNft = deployer.run();
        // } else {
        //     basicNft = new BasicNft();
        // }
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testInitializedCorrectly() public view {
        // 普通的string类型的数组没法直接比较，但是bytes32的字节数组可以直接比较
        assert(keccak256(abi.encodePacked(basicNft.name())) == keccak256(abi.encodePacked((NFT_NAME))));
        assert(keccak256(abi.encodePacked(basicNft.symbol())) == keccak256(abi.encodePacked((NFT_SYMBOL))));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assert(basicNft.balanceOf(USER) == 1);
    }

    function testTokenURIIsCorrect() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG_URI)));
    }
}
