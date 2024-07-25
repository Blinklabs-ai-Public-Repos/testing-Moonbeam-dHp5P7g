// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HelloABN is ERC20, Ownable {
    uint256 private immutable _maxSupply;

    /**
     * @dev Constructor that sets the name, symbol, and max supply of the token.
     * @param name_ The name of the token.
     * @param symbol_ The symbol of the token.
     * @param maxSupply_ The maximum supply of the token.
     */
    constructor(string memory name_, string memory symbol_, uint256 maxSupply_) 
        ERC20(name_, symbol_) 
        Ownable()
    {
        require(maxSupply_ > 0, "Max supply must be greater than zero");
        _maxSupply = maxSupply_;
    }

    /**
     * @dev Mints new tokens to the specified address.
     * @param to The address to mint tokens to.
     * @param amount The amount of tokens to mint.
     * @notice Only the owner can call this function.
     */
    function mint(address to, uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= _maxSupply, "Minting would exceed max supply");
        _mint(to, amount);
    }

    /**
     * @dev Burns tokens from the caller's account.
     * @param amount The amount of tokens to burn.
     */
    function burn(uint256 amount) external {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev Returns the maximum supply of the token.
     * @return The maximum supply.
     */
    function maxSupply() external view returns (uint256) {
        return _maxSupply;
    }
}