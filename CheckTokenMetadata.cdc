import PinataPartyContract from 0x1930854f0e15a89f

pub fun main() : {String : String} {
    let nftOwner = getAccount(0x1930854f0e15a89f)
    // log("NFT Owner")
    let capability = nftOwner.getCapability<&{PinataPartyContract.NFTReceiver}>(/public/NFTReceiver)

    let receiverRef = capability.borrow()
        ?? panic("Could not borrow the receiver reference")

    return receiverRef.getMetadata(id: 1)
}