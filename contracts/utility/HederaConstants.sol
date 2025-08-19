// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

/**
 * @dev Hedera Token Service (HTS) constants for use across contracts.
 * Contains HTS precompile address and response codes for token association.
 */
library HederaConstants {
    // HTS precompile address
    address internal constant HTS_ADDRESS = 0x0000000000000000000000000000000000000167;

    // HTS response codes
    int64 internal constant RC_SUCCESS = 22; // Successful token association
    int64 internal constant RC_ALREADY = 194; // Token already associated
    int32 internal constant RC_TOKEN_NOT_ASSOCIATED_TO_ACCOUNT = 184; // A required token-account relationship is missing
}
