pragma solidity ^0.4.23;


contract Car {
    enum VisitType {Inspection, Repair, Overhaul}

    struct Visit {
        uint32 mileage;
        VisitType visitType;
    }

    bytes32 private id;
    mapping(bytes32 => mapping(uint => Visit)) registerOfVisits;
    mapping(bytes32 => uint) visitCounter;

    constructor(bytes32 _id) public {
        id = _id;
    }

    function registerVisit(uint32 _mileage, VisitType _visitType) public {
        registerOfVisits[id][visitCounter[id]].mileage = _mileage;
        registerOfVisits[id][visitCounter[id]].visitType = _visitType;
        visitCounter[id]++;
    }

    function visitsCount() public view returns (uint) {
        return visitCounter[id];
    }

    function hasBeenOverhauled() public view returns (bool) {
        if (registerOfVisits[id][visitCounter[id] - 1].visitType == VisitType.Overhaul) {
            return true;
        } else {
            return false;
        }
    }

    function getLastKnownMileage() public view returns (uint32) {
        uint32 lastKnow = registerOfVisits[id][visitCounter[id] - 1].mileage;
        return lastKnow;
    }
}
