//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Token {
    uint256 public totalSuppl = 1000000e18;
    mapping(address => uint256) public balancOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => bool) public isBlacklisted;
    address public owner;
    string public name = "Morrison";
    string public symbol = "js";
    uint8 public decimal = 18;

    constructor() {
        owner = msg.sender;
        // address that deploys contract will be the owner
    }

    function newBlackList(address _user) public  {
        require(!isBlacklisted[_user], "you are blacklisted");
        isBlacklisted[_user] = true;
        // emit events as well
    }

    function totalSupply() external view returns (uint256) {
        return totalSuppl;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balancOf[account];
    }

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
       require(!isBlacklisted[msg.sender], "user is backlisted");
        balancOf[msg.sender] -= amount;
        balancOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowanc(address owne, address spender)
        external
        view
        returns (uint256)
    {
        return allowance[owne][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function mint() public {
        balancOf[msg.sender] = 500e18;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        allowance[sender][recipient] -= amount;
        balancOf[sender] -= amount;
        balancOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approve( address indexed owner,address indexed spender,uint256 amount);
}