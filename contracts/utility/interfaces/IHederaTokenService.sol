// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

// HTS interface
interface IHederaTokenService {
    function associateToken(address account, address token) external returns (int64 responseCode);
    function associateTokens(address account, address[] memory tokens) external returns (int64 responseCode);
    function dissociateToken(address account, address token) external returns (int64 responseCode);
    function dissociateTokens(address account, address[] memory tokens) external returns (int64 responseCode);
}
