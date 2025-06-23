// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0 <0.9.0;

contract Funding {
    // 1. 管理员（项目发起人）
    address public manager;

    // 2. 项目名称
    string public projectName;

    // 3. 目标资金
    uint256 public targetMoney;

    // 4. 每个人支持多少钱
    uint256 public supportMoney;

    // 5. 项目结束时间
    uint256 public endTime;

    // 维护所有参与者
    address[] investors;

    constructor(string memory _projectName, uint256 _targetMoney, uint256 _supportMoney, uint256 _duration) {
        manager = msg.sender;
        projectName = _projectName;
        targetMoney = _targetMoney;
        supportMoney = _supportMoney;
        endTime = block.timestamp + _duration;
    }

    function invest() payable public {
        require(msg.value == supportMoney);
        investors.push(msg.sender);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getInvestors()public view returns (address[] memory) {
        return investors;
    }
}