import Nftly from 0xa31975fccc40116e

// This transaction configures a user's account
// to use the NFT contract by creating a new empty collection,
// storing it in their account storage, and publishing a capability
transaction {
    prepare(acct: AuthAccount) {

        // Create a new empty collection
        let collection <- Nftly.createEmptyCollection()

        // store the empty NFT Collection in account storage
        acct.save<@Nftly.Collection>(<-collection, to: /storage/NFTCollection)

        log("Collection created for account 1")

        // create a public capability for the Collection
        acct.link<&{Nftly.NFTReceiver}>(/public/NFTReceiver, target: /storage/NFTCollection)

        log("Capability created")
    }
}
