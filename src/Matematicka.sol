// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title A simple ERC20 token example
contract Matematicka {
    // Token metadata
    string public name = "Matematicka Gimnasia";
    string public symbol = "MG";
    uint8 public decimals = 16;

    // Total supply of tokens
    uint256 public totalSupply;

    // Mapping from account addresses to current balance.
    mapping(address => uint256) private balances;
    // Mapping from account addresses to a mapping of spender addresses to an allowance amount.
    mapping(address => mapping(address => uint256)) private allowances;

    // Events as defined in the ERC20 standard.
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /// @notice Constructor that gives msg.sender all of the tokens.
    /// @param initialSupply The total number of tokens that will exist (in wei units).
    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply;
        emit Transfer(address(0), msg.sender, initialSupply);
    }

    /// @notice Returns the balance of the specified address.
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    /// @notice Transfers tokens to a specified address.
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    /// @notice Approves a spender to transfer tokens on your behalf.
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Approve to the zero address");

        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /// @notice Returns the remaining number of tokens that a spender can spend on behalf of an owner.
    function allowance(address owner, address spender) public view returns (uint256) {
        return allowances[owner][spender];
    }

    /// @notice Transfers tokens on behalf of the owner using the allowance mechanism.
    function transferFrom(
        address owner,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        require(owner != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(balances[owner] >= amount, "Insufficient balance");
        require(allowances[owner][msg.sender] >= amount, "Allowance exceeded");

        balances[owner] -= amount;
        balances[recipient] += amount;
        allowances[owner][msg.sender] -= amount;

        emit Transfer(owner, recipient, amount);
        return true;
    }
}