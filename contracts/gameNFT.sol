pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract GameItems is ERC1155 {
    uint256 public constant COPPER = 0;
    uint256 public constant CRYSTAL = 1;
   // uint256 public constant ELDER_SWORD = 2;
  //  uint256 public constant KNIFE = 3;
  //  uint256 public constant WAND = 4;

    constructor() ERC1155("https://bafybeif3emwbifvkbx3moxu2er6pwsgxovjh2ihlp226pazei4hjphz5uu.ipfs.dweb.link/") {
        _mint(msg.sender, COPPER, 10**18, "");
        _mint(msg.sender, CRYSTAL, 10**27, "");
       // _mint(msg.sender, ELDER_SWORD, 1, "");
      //  _mint(msg.sender, KNIFE, 10**9, "");
      //  _mint(msg.sender, WAND, 10**9, "");
    }

    function uri(uint256 _tokenId) override public view returns (string memory){
        return string(
            abi.encodePacked(
                "https://bafybeif3emwbifvkbx3moxu2er6pwsgxovjh2ihlp226pazei4hjphz5uu.ipfs.dweb.link/",
                Strings.toString(_tokenId),
                ".json"
            )
        );
    }
}