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
    payable address[] investors;

    constructor(string memory _projectName, uint256 _targetMoney, uint256 _supportMoney, uint256 _duration) {
        manager = msg.sender;
        projectName = _projectName;
        targetMoney = _targetMoney;
        supportMoney = _supportMoney;
        endTime = block.timestamp + _duration;
    }

    // 投资者进行投资
    function invest() payable public {
        require(msg.value == supportMoney);
        investors.push(msg.sender);
    }

    // 查看当前总额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 获取当前投资者
    function getInvestors()public view returns (address[] memory) {
        return investors;
    }

    // 退款，由外层（前端）调用
    function refund() public {

        for (uint256 i = 0; i < investors.length; i++) {
            investors[i].transfer(supportMoney);
        }
        // 投资者清零
        delete investors;
    }

    // 花费请求
    

}