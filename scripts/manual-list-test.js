const { ethers } = require("hardhat");

async function main() {
  const domainName = "test"; // Replace with your domain
  const priceInCTC = "1000"; // Replace with your desired price
  
  const mktAddress = process.env.NEXT_PUBLIC_MARKETPLACE_CONTRACT_ADDRESS;
  const mkt = await ethers.getContractAt("CreditNameMarketplace", mktAddress);
  
  const listingFee = await mkt.LISTING_FEE();
  const priceWei = ethers.parseEther(priceInCTC);
  
  console.log(`Attempting to list ${domainName} for ${priceInCTC} CTC`);
  console.log(`Listing fee: ${ethers.formatEther(listingFee)} CTC`);
  
  try {
    const tx = await mkt.list(domainName, priceWei, { value: listingFee });
    await tx.wait();
    console.log("✅ Successfully listed domain!");
    console.log("Transaction hash:", tx.hash);
  } catch (error) {
    console.error("❌ Failed to list domain:", error.message);
    
    // Try to get more specific error info
    if (error.reason) {
      console.error("Revert reason:", error.reason);
    }
  }
}

main().catch(console.error);