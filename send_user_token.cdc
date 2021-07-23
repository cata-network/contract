// Transfer Tokens

import NftlyToken from  0xa31975fccc40116e

// This transaction is a template for a transaction that
// could be used by anyone to send tokens to another account
// that owns a Vault
transaction(amount: UFix64, to: Address) {

  // Temporary Vault object that holds the balance that is being transferred
  var temporaryVault: @NftlyToken.Vault

  prepare(acct: AuthAccount) {
    // withdraw tokens from your vault by borrowing a reference to it
    // and calling the withdraw function with that reference
    let vaultRef = acct.borrow<&NftlyToken.Vault>(from: /storage/MainVault)
        ?? panic("Could not borrow a reference to the owner's vault")

    self.temporaryVault <- vaultRef.withdraw(amount: amount)
  }

  execute {
    // get the recipient's public account object
    let recipient = getAccount(to)

    // get the recipient's Receiver reference to their Vault
    // by borrowing the reference from the public capability
    let receiverRef = recipient.getCapability(/public/MainReceiver)
                      .borrow<&NftlyToken.Vault{NftlyToken.Receiver}>()
                      ?? panic("Could not borrow a reference to the receiver")

    // deposit your tokens to their Vault
    receiverRef.deposit(from: <-self.temporaryVault)

    log("Transfer succeeded!")
  }
}
