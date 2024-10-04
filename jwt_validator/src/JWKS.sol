pragma solidity ^0.6.0;

contract JWKS {
  address admin;

  mapping(string => bytes) keys;

  constructor() public {
    admin = msg.sender;
  }

  function addKey(string memory kid, bytes memory modulus) public {
    keys[kid] = modulus;
  }

  function getModulus(string memory kid) public view returns (bytes memory) {
    return keys[kid];
  }
}