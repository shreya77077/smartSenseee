// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TodoList {
    struct Todo {
        string things;
        bool completed;
        uint256 deadline;
    }

    mapping(address => mapping(uint => Todo[])) public User;

    function userstore(string calldata _things, uint256 _deadline, uint id) public {
        User[msg.sender][id].push(Todo(_things, false, block.timestamp + _deadline));
    }

    function updateThings(uint256 _index, string calldata _things, uint id) public {
        User[msg.sender][id][_index].things = _things;
    }

    function toggleCompleted(uint256 _index, uint id) external {
        Todo storage todo = User[msg.sender][id][_index];
        require(!todo.completed, "Already completed");
        require(block.timestamp < todo.deadline, "Deadline passed");
        todo.completed = true;
    }

    function remove(uint256 _index, uint id) public returns (Todo[] memory) {
         for (uint256 i = _index; i < User[msg.sender][id].length - 1; i++) {
            User[msg.sender][id][i] = User[msg.sender][id][i + 1];
        }
        User[msg.sender][id].pop();

        return User[msg.sender][id];
    }
}
