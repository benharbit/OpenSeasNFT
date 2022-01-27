const { expect } = require("chai");
const { ethers, waffle } = require("hardhat");
const util = require('util');	
//	console.log(util.inspect(expect))
const provider = waffle.provider;


let owner, client1, client2, client3;
let factory, router, myCnt, myWETH, pairV2;
let clientAddresses;
let gameItems;

async function mineNBlocks(n) {
  for (let index = 0; index < n; index++) {
    await ethers.provider.send('evm_mine');
  }
}


beforeEach(async function () {
    [owner, client1, client2, client3, marketingWallet, devWallet] = await ethers.getSigners();
    clientAddresses = [client1.address, client2.address, client3.address];

    
    GameItems = await ethers.getContractFactory('GameItems')
    gameItems = await GameItems.deploy()
    gameItems2 = await GameItems.deploy()

    //gameItems.safeTransferFrom(owner.address, client1.address , 2, 1, "0x")
    //UniswapV2Router02 = await ethers.getContractFactory('UniswapV2Router02')
   // ThreeNAME = await ethers.getContractFactory('ThreeNAME')
    //UniswapV2Pair = await ethers.getContractFactory('contracts/pairV2.sol:UniswapV2Pair')
   // UniswapV2Pair = await hre.reef.getContractFactory('contracts/pairV2.sol:UniswapV2Pair');


  //  console.log("client1 Eth Balance: " + await provider.getBalance(client1.address))
    
  //  WETH = await ethers.getContractFactory('WETH9')
    //myWETH = await WETH.deploy()
    //factory = await UniswapV2Factory.deploy(owner.address)
   // router = await UniswapV2Router02.deploy(factory.address, myWETH.address)
    
  //  myCnt = await ThreeNAME.deploy()
})


it("test transfer of NFT", async function () {
	await gameItems.safeTransferFrom(owner.address, client1.address , 1  , 1, "0x")
/	expect((await gameItems.balanceOf(client1.address,1))).to.equal(1)
	return true;
})

/*
it("test transfer of NFT to another contract", async function () {
	await gameItems.safeTransferFrom(owner.address, gameItems2.address , 2, 1, "0x")
	expect((await gameItems.balanceOf(gameItems2.address,2))).to.equal(1)
	return true;
})
*/

it("print URI ", async function () {
	console.log("URI 0" + await gameItems.uri(0))
	console.log("URI 1" + await gameItems.uri(1))
	return true;
})




