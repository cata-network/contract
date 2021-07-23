// Setup Account

import NftlyToken from  0xa31975fccc40116e

// This transaction configures an account to store and receive tokens defined by
// the ExampleToken contract.
transaction() {
	prepare(acct: AuthAccount) {
		// Create a new empty Vault object
		let vaultA <- NftlyToken.createEmptyVault()

		// Store the vault in the account storage
		acct.save<@NftlyToken.Vault>(<-vaultA, to: /storage/MainVault)

    log("Empty Vault stored")

    // Create a public Receiver capability to the Vault
		let ReceiverRef = acct.link<&NftlyToken.Vault{NftlyToken.Receiver, NftlyToken.Balance}>(/public/MainReceiver, target: /storage/MainVault)

    log("References created")
	}

    post {
        // Check that the capabilities were created correctly
    }
}