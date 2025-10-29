⚡ Simple Flash Loan Provider (Solidity)

A beginner-friendly Flash Loan Provider smart contract built with Solidity (v0.8.19).
This project demonstrates the core mechanics of flash loans — instant, no-collateral loans that must be repaid within the same blockchain transaction.

🧠 Project Description

This project is a simplified educational example of how a flash loan works under the hood.
Flash loans are commonly used in DeFi (Decentralized Finance) protocols for arbitrage, liquidation, and collateral swapping — all without needing upfront capital.

This smart contract allows a borrower to request a loan from a liquidity pool, perform an operation, and repay the loan plus a small fee, all within one transaction.
If the repayment fails, the transaction is automatically reverted — ensuring that no funds are lost.

💡 What It Does

Holds ERC20 tokens in a liquidity pool.

Provides instant loans to borrowers who implement the required interface.

Checks repayment of the borrowed amount plus a fixed fee.

Reverts the entire transaction if repayment conditions aren’t met.

This ensures atomic execution — either everything succeeds, or nothing happens.

🌟 Features

🪙 ERC20-Compatible — Works with any ERC20 token.

🔐 Owner Control — Only the owner can withdraw funds from the pool.

⚡ Instant Repayment Verification — Ensures safety through automatic reverts.

💵 Fixed Fee System — A simple, flat-rate fee model for easy understanding.

🧰 Educational Design — Clean, readable, and well-commented for Solidity beginners.

🔗 Deployed Smart Contract

You can view the deployed transaction and interact with it on the Celo Sepolia Testnet:
👉 View on Celo BlockScout

🚀 How to Use
🧱 Prerequisites

Remix IDE
 or Hardhat

A Celo-compatible wallet (e.g., MetaMask)

Some test tokens (e.g., cUSD on Celo Sepolia)

⚙️ Steps

Deploy the FlashLoanProvider contract.

Provide liquidity using depositTokens(amount) with an ERC20 token.

Deploy a borrower contract that implements IFlashLoanReceiver.

Request a flash loan via requestFlashLoan(amount).

Observe the transaction — if repayment (amount + fee) succeeds, it completes; otherwise, it reverts.

🧠 Educational Notes

Flash loans are risk-free for lenders due to atomic execution.

Common real-world uses include arbitrage, collateral swaps, and liquidation bots.

Always test on testnets (like Celo Sepolia or Alfajores) before deploying to mainnets.


📚 References

Celo Developer Documentation

Solidity Language Docs

OpenZeppelin Contracts

Aave Flash Loans Explained
