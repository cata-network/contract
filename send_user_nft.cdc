// Transaction4.cdc
import Nftly from 0xa31975fccc40116e

// This transaction transfers an NFT from one user's collection
// to another user's collection.
transaction(id: UInt64, to: Address) {

    // The field that will hold the NFT as it is being
    // transferred to the other account
    let transferToken: @Nftly.NFT
    let sendRef: &{Nftly.NFTReceiver}

    prepare(acct: AuthAccount) {

        self.sendRef = acct.getCapability<&{Nftly.NFTReceiver}>(/public/NFTReceiver)
          .borrow()
          ?? panic("Could not borrow receiver reference")

        // Borrow a reference from the stored collection
        let collectionRef = acct.borrow<&Nftly.Collection>(from: /storage/NFTCollection)
            ?? panic("Could not borrow a reference to the owner's collection")


        // Call the withdraw function on the sender's Collection
        // to move the NFT out of the collection
        self.transferToken <- collectionRef.withdraw(withdrawID: id)
    }

    execute {
        // Get the recipient's public account object
        let recipient = getAccount(to)

        // Get the Collection reference for the receiver
        // getting the public capability and borrowing a reference from it
        let receiverRef = recipient.getCapability<&{Nftly.NFTReceiver}>(/public/NFTReceiver)
            .borrow()
            ?? panic("Could not borrow receiver reference")

        let metadata: {String: String} = self.sendRef.getMetadata(id: id)

        // Deposit the NFT in the receivers collection
        receiverRef.deposit(token: <-self.transferToken, metadata: metadata)
    }
}
