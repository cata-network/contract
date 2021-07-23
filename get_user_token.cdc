import NftlyToken from  0xa31975fccc40116e

// This script reads the Vault balances of two accounts.

pub fun main(account: Address): UFix64 {
    // Get the accounts' public account objects
    let acct = getAccount(account)

    // Get references to the account's receivers
    // by getting their public capability
    // and borrowing a reference from the capability
    let acctReceiverRef = acct.getCapability<&NftlyToken.Vault{NftlyToken.Balance}>(/public/MainReceiver)
        .borrow()
        ?? panic("Could not borrow a reference to the acct1 receiver")

    // Read and log balance fields
    return acctReceiverRef.balance

}