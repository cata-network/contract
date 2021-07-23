// Script1.cdc

import Nftly from 0xa31975fccc40116e


pub fun main(to: Address) : [UInt64]  {
    // Get the public account object for account 0x02
    let nftOwner = getAccount(to)

    // Find the public Receiver capability for their Collection
    let capability = nftOwner.getCapability<&{Nftly.NFTReceiver}>(/public/NFTReceiver)

    // borrow a reference from the capability
    let receiverRef = capability.borrow()
        ?? panic("Could not borrow the receiver reference")

    // Log the NFTs that they own as an array of IDs
    log("Account 2 NFTs")
    return receiverRef.getIDs()
}
