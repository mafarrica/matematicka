# SPDX-License-Identifier: MIT

# @title A simple ERC20 token example
# @dev Converted from Solidity to Vyper

@external
@view
def name() -> String[32]:
    return "Matematicka Gimnasia"

@external
@view
def symbol() -> String[16]:
    return "MG"

@external
@view
def decimals() -> uint8:
    return 16

# Total supply of tokens
total_supply: public(uint256)

# Mapping from account addresses to current balance.
balances: public(HashMap[address, uint256])
# Mapping from account addresses to a mapping of spender addresses to an allowance amount.
allowances: public(HashMap[address, HashMap[address, uint256]])

# Events as defined in the ERC20 standard.
event Transfer:
    sender: indexed(address)
    receiver: indexed(address)
    value: uint256

event Approval:
    owner: indexed(address)
    spender: indexed(address)
    value: uint256

@external
def __init__(initial_supply: uint256):
    self.total_supply = initial_supply
    self.balances[msg.sender] = initial_supply
    log Transfer(ZERO_ADDRESS, msg.sender, initial_supply)

@external
@view
def balanceOf(account: address) -> uint256:
    return self.balances[account]

@external
def transfer(recipient: address, amount: uint256) -> bool:
    assert recipient != ZERO_ADDRESS, "Transfer to the zero address"
    assert self.balances[msg.sender] >= amount, "Insufficient balance"
    
    self.balances[msg.sender] -= amount
    self.balances[recipient] += amount
    log Transfer(msg.sender, recipient, amount)
    return True

@external
def approve(spender: address, amount: uint256) -> bool:
    assert spender != ZERO_ADDRESS, "Approve to the zero address"
    self.allowances[msg.sender][spender] = amount
    log Approval(msg.sender, spender, amount)
    return True

@external
@view
def allowance(owner: address, spender: address) -> uint256:
    return self.allowances[owner][spender]

@external
def transferFrom(owner: address, recipient: address, amount: uint256) -> bool:
    assert owner != ZERO_ADDRESS, "Transfer from the zero address"
    assert recipient != ZERO_ADDRESS, "Transfer to the zero address"
    assert self.balances[owner] >= amount, "Insufficient balance"
    assert self.allowances[owner][msg.sender] >= amount, "Allowance exceeded"
    
    self.balances[owner] -= amount
    self.balances[recipient] += amount
    self.allowances[owner][msg.sender] -= amount
    log Transfer(owner, recipient, amount)
    return True
