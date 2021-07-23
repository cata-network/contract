import Nftly from 0xa31975fccc40116e

transaction(metadata : {String : String}) {
  let receiverRef: &{Nftly.NFTReceiver}
  let minterRef: &Nftly.NFTMinter

  prepare(acct: AuthAccount) {
      self.receiverRef = acct.getCapability<&{Nftly.NFTReceiver}>(/public/NFTReceiver)
          .borrow()
          ?? panic("Could not borrow receiver reference")

      self.minterRef = acct.borrow<&Nftly.NFTMinter>(from: /storage/NFTMinter)
          ?? panic("could not borrow minter reference")
  }

  execute {
      let metadata : {String : String} = metadata
      let newNFT <- self.minterRef.mintNFT()

      self.receiverRef.deposit(token: <-newNFT, metadata: metadata)

      log("NFT Minted and deposited Collection")


  }
}