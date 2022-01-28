pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract GameItems is ERC1155,  Ownable {
   using SafeMath for uint256;
   using Address for address;
   uint256 constant MAX_SUPPLY = 10; 
   uint256 constant tokenPrice = .01 ether;    
   uint256 constant MAX_TOKEN_PURCHASE = 2;
   bool saleIsActive  = true;
   uint256 tokensMinted = 0;
   bool public isAllowListActive = false;
   mapping(address => uint8) private _allowList;
   bool public revealed = false;
   string public notRevealedUri;

    constructor() ERC1155("https://bafybeif3emwbifvkbx3moxu2er6pwsgxovjh2ihlp226pazei4hjphz5uu.ipfs.dweb.link/") {
     //   _mint(msg.sender, COPPER, 10**18, "");
     //   _mint(msg.sender, CRYSTAL, 10**27, "");
        reserveTokens();
    }

    function uri(uint256 _tokenId) override public view returns (string memory){

        if(revealed == false) {
            return notRevealedUri;
        }
        return string(
            abi.encodePacked(
                "https://bafybeif3emwbifvkbx3moxu2er6pwsgxovjh2ihlp226pazei4hjphz5uu.ipfs.dweb.link/",
                Strings.toString(_tokenId),
                ".json"
            )
        );
    }

    function mint(uint numberOfTokens) public payable {
        require(saleIsActive, "Sale must be active to mint");
        require(numberOfTokens <= MAX_TOKEN_PURCHASE, "Can only mint 2 tokens at a time");
        require(tokensMinted.add(numberOfTokens) <= MAX_SUPPLY, "Purchase would exceed max supply of Apes");
        require(tokenPrice.mul(numberOfTokens) <= msg.value, "Ether value sent is not correct");
        
        for(uint i = 0; i < numberOfTokens; i++) {
            uint mintIndex = tokensMinted;
            if (tokensMinted < MAX_SUPPLY) {
                _mint(msg.sender, mintIndex, 1, "");
                tokensMinted += 1;
            }
        }
    }

    function flipSaleState() public onlyOwner {
        saleIsActive = !saleIsActive;
    }

     function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }


     function reserveTokens() public onlyOwner {        
        uint i;
        for (i = 0; i < 3; i++) {
            _mint(msg.sender, i, 1, "");
            tokensMinted++;
        }
    }

    function setAllowList(address[] calldata addresses, uint8 numAllowedToMint) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            _allowList[addresses[i]] = numAllowedToMint;
        }
    }

    function mintAllowList(uint8 numberOfTokens) external payable {
        uint256 ts = tokensMinted;

        require(isAllowListActive, "Allow list is not active");
        require(numberOfTokens <= _allowList[msg.sender], "Exceeded max available to purchase");
        require(ts + numberOfTokens <= MAX_SUPPLY, "Purchase would exceed max tokens");
        require(tokenPrice * numberOfTokens <= msg.value, "Ether value sent is not correct");

        _allowList[msg.sender] -= numberOfTokens;
        for (uint256 i = 0; i < numberOfTokens; i++) {
            _mint(msg.sender, ts + i,1,"");
        }
    }
   
    function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
        notRevealedUri = _notRevealedURI;
    }

    function reveal() public onlyOwner {
      revealed = true;
    }
}


