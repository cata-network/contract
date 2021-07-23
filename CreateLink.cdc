// Create Link

import NftlyToken from 0xa31975fccc40116e

// This transaction creates a capability
// that is linked to the account's token vault.
// The capability is restricted to the fields in the `Receiver` interface,
// so it can only be used to deposit funds into the account.
transaction {
  prepare(acct: AuthAccount) {

    // Create a link to the Vault in storage that is restricted to the
    // fields and functions in `Receiver` and `Balance` interfaces,
    // this only exposes the balance field
    // and deposit function of the underlying vault.
    //
    acct.link<&NftlyToken.Vault{NftlyToken.Receiver, NftlyToken.Balance}>(/public/MainReceiver, target: /storage/MainVault)

    log("Public Receiver reference created!")
  }
}