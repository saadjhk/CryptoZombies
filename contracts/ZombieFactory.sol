pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string _name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name) private {
        uint dna = _generateZombieDna(_name);
        zombies.push(Zombie(_name, dna));
    }

    function _generateZombieDna(string memory _name) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_name)));
        return rand;
    }

    function generateRandomZombie(string memory _name) public {
        _createZombie(_name);
    }
}