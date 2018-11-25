pragma solidity ^0.4.17;

contract LaborContract {
    struct Modification {
        address operator;
        uint time;
        string key;
        string from;
        string to;
    }
    struct Sign {
       address signer;
       uint time;
    }
    address public partyA;
    address public partyB;
    string public partyA_name;
    string public partyB_name;
    uint public startDate;
    uint public endDate;
    uint public salary;
    string public job;
    Modification[] public modifyHistory;
    Sign[] public signHistory;
    
    constructor(string _partyA_name, uint _startDate, uint 
    _endDate, uint _salary, string _job) public {
        partyA = msg.sender;
        partyA_name = _partyA_name;
        startDate = _startDate;
        endDate = _endDate;
        salary = _salary;
        job = _job;
    }
    
    function sign() public{
        if (msg.sender == partyA || msg.sender == partyB) {
            Sign memory newSign = Sign({
                signer: msg.sender,
                time: now
             });
            if (signHistory.length < 2) {
                signHistory.push(newSign);
            }
        }
    }
    
    function designateParty(uint party) public {
        if (party == 1) {
            partyA = msg.sender;
        } else {
            partyB = msg.sender;
        }
    }
    
}