// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
 *  Simple Flash Loan Example
 *  -------------------------
 *  This contract:
 *  1. Holds ERC20 tokens (the liquidity pool).
 *  2. Lets borrowers request a flash loan.
 *  3. Requires repayment + fee in the same transaction.
 *  4. If repayment fails → transaction reverts automatically.
 *
 *  Note: This is a simplified educational demo — not for production.
 */

interface IERC20 {
    function transfer(address to, uint amount) external returns (bool);
    function transferFrom(address from, address to, uint amount) external returns (bool);
    function balanceOf(address account) external view returns (uint);
}

contract FlashLoanProvider {
    IERC20 public token;           // Token used for flash loan
    uint public fee = 10;          // Fixed fee in token's smallest unit (for simplicity)
    address public owner;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Owner can withdraw tokens from pool
    function withdrawTokens(uint amount) external onlyOwner {
        require(token.transfer(owner, amount), "Withdraw failed");
    }

    // Deposit tokens into this contract (the liquidity pool)
    function depositTokens(uint amount) external {
        require(token.transferFrom(msg.sender, address(this), amount), "Deposit failed");
    }

    // Main flash loan function
    function requestFlashLoan(uint amount) external {
        uint balanceBefore = token.balanceOf(address(this));
        require(balanceBefore >= amount, "Not enough liquidity");

        // Send tokens to borrower
        require(token.transfer(msg.sender, amount), "Loan transfer failed");

        // Execute borrower’s logic (custom action during the flash loan)
        IFlashLoanReceiver(msg.sender).executeOperation(amount, fee);

        // Verify loan repayment
        uint balanceAfter = token.balanceOf(address(this));
        require(balanceAfter >= balanceBefore + fee, "Loan not repaid");

        // Flash loan successful
    }
}

// Interface for borrower contract
interface IFlashLoanReceiver {
    function executeOperation(uint amount, uint fee) external;
}

