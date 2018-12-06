pragma solidity ^0.4.17;

contract LaborContractList {
    address[] laborContracts;
    function createLaborContract(uint _startDate, uint 
    _endDate, uint _salary, string _job, address _partyB, string name) public {
        address newLaborContract = new LaborContract(_startDate, _endDate, _salary, _job, msg.sender, _partyB, name);
        laborContracts.push(newLaborContract);
    }
    function getContracts() public view returns(address[]) {
        return laborContracts;
    }

}

contract LaborContract {
    struct Modification {
        address operator;
        uint time;
        string m_type;
        string content;
    }
    struct Sign {
       address signer;
       uint time;
    }
    address public partyA;
    address public partyB;
    uint public startDate;
    uint public endDate;
    uint public salary;
    string public job;
    string public status;
    string public name;
    Modification[] public modifyHistory;
    Sign[] public signHistory;
    
    constructor(uint _startDate, uint 
    _endDate, uint _salary, string _job, address _partyA, address _partyB, string _name) public {
        partyA = _partyA;
        partyB = _partyB;
        startDate = _startDate;
        endDate = _endDate;
        salary = _salary;
        job = _job;
        name = _name;
        status = 'sign';
        Modification memory newModification = Modification({
            operator: _partyA,
            time: now,
            m_type: 'create',
            content: '创建合同'
        });
        modifyHistory.push(newModification);
    }
    
    function getSummary() public view returns (string, address, address, string, string) {
        return (
            job,
            partyA,
            partyB,
            name,
            status
        );
    }
    
    function sign() public{
        if (signHistory.length == 0 && (msg.sender == partyA || msg.sender == partyB)) {
            Sign memory newSign = Sign({
                signer: msg.sender,
                time: now
             });
             signHistory.push(newSign);
        } else if (signHistory.length == 1) {
            if (signHistory[0].signer != msg.sender && (msg.sender == partyA || msg.sender == partyB)) {
                Sign memory newSign2 = Sign({
                signer: msg.sender,
                time: now
             });
             signHistory.push(newSign2);
             status = 'finish';
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
    

    function getDetail() public view returns (uint, uint, uint, string, address, address, string, string) {
        return (
            startDate,
            endDate,
            salary,
            job,
            partyA,
            partyB,
            name,
            status
        );
    }

    function getHistoryLength() public view returns (uint) {
        return modifyHistory.length;
    }

    function getHistory(uint index) public constant returns (address, uint, string, string) {
        return (
            modifyHistory[index].operator,
            modifyHistory[index].time,
            modifyHistory[index].m_type,
            modifyHistory[index].content
        );
    }

    function getSignHistoryLength() public view returns (uint) {
        return signHistory.length;
    }

    function getSignHistory(uint index) public constant returns (address, uint) {
        return (
            signHistory[index].signer,
            signHistory[index].time
        );
    }       
}