pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string _name;
        uint dna;
    }

    Zombie[] public zombies;
    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;

    event NewZombie(uint zombieId, string name, uint dna);

    function _createZombie(string memory _name) internal {
        uint dna = _generateZombieDna(_name);
        uint id = zombies.push(Zombie(_name, dna));
        zombieToOwner[dna] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, dna);
    }

    function _generateZombieDna(string memory _name) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_name)));
        return rand;
    }

    function generateRandomZombie(string memory _name) public {
        // only create one zombie per user?
        require(ownerZombieCount[msg.sender] == 0);
        _createZombie(_name);
    }
}