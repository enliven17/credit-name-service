const { ethers } = require("hardhat");

async function main() {
  console.log("Deploying CreditNameService and CreditNameMarketplace to Creditcoin Testnet...");

  const initialOwner = process.env.DEPLOYER_ADDRESS || process.env.CONTRACT_OWNER_ADDRESS;
  if (!initialOwner) throw new Error("Missing DEPLOYER_ADDRESS env");

  const NSFactory = await ethers.getContractFactory("CreditNameService");
  const ns = await NSFactory.deploy(initialOwner);
  await (ns.waitForDeployment?.() || ns.deployed?.());
  const nsAddr = ns.address || (await ns.getAddress?.());
  console.log("CreditNameService:", nsAddr);

  const MktFactory = await ethers.getContractFactory("CreditNameMarketplace");
  const mkt = await MktFactory.deploy(nsAddr, initialOwner);
  await (mkt.waitForDeployment?.() || mkt.deployed?.());
  const mktAddr = mkt.address || (await mkt.getAddress?.());
  console.log("CreditNameMarketplace:", mktAddr);

  const tx = await ns.setMarketplace(mktAddr);
  await tx.wait();
  console.log("Linked marketplace in NameService.");

  console.log(`NEXT_PUBLIC_CREDIT_CONTRACT_ADDRESS=${nsAddr}`);
  console.log(`NEXT_PUBLIC_MARKETPLACE_CONTRACT_ADDRESS=${mktAddr}`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});


