// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import { HederaConstants } from "./HederaConstants.sol";
import { IHederaTokenService } from "./interfaces/IHederaTokenService.sol";

/**
 * @dev Library for Hedera Token Service (HTS) interactions.
 * Provides reusable functions for token association.
 */
library HederaTokenService {
    // Error
    error HTSAssociationFailed(int64 responseCode);
    error InvalidLength();

    // Event for tracking token associations
    event TokenAssociated(address indexed token, int64 responseCode);
    event TokensAssociated(address[] tokens, int64 responseCode);
    event TokenDissociated(address indexed token, int64 responseCode);
    event TokensDissociated(address[] tokens, int64 responseCode);

    /**
     * @dev Associates a single HTS token with the specified account
     * @param account The account to associate the token with (typically the contract)
     * @param token The HTS token address
     */
    function _associateToken(address account, address token) internal returns (int64 rc) {
        rc = IHederaTokenService(HederaConstants.HTS_ADDRESS).associateToken(account, token);
        if (rc != HederaConstants.RC_SUCCESS && rc != HederaConstants.RC_ALREADY) revert HTSAssociationFailed(rc);

        emit TokenAssociated(token, rc);
    }

    /**
     * @dev Batch associates multiple HTS tokens with the specified account
     * @param account The account to associate the tokens with
     * @param tokens Array of HTS token addresses
     */
    function _batchAssociateTokens(address account, address[] memory tokens) internal returns (int64 rc) {
        if (tokens.length == 0) revert InvalidLength();

        rc = IHederaTokenService(HederaConstants.HTS_ADDRESS).associateTokens(account, tokens);
        if (rc != HederaConstants.RC_SUCCESS && rc != HederaConstants.RC_ALREADY) revert HTSAssociationFailed(rc);

        emit TokensAssociated(tokens, rc);
    }

    /**
     * @dev Dissociates a single HTS token with the specified account
     * @param account The account to dissociate the token with (typically the contract)
     * @param token The HTS token address
     */
    function _dissociateToken(address account, address token) internal returns (int64 rc) {
        rc = IHederaTokenService(HederaConstants.HTS_ADDRESS).dissociateToken(account, token);
        if (rc != HederaConstants.RC_SUCCESS && rc != HederaConstants.RC_TOKEN_NOT_ASSOCIATED_TO_ACCOUNT)
            revert HTSAssociationFailed(rc);

        emit TokenDissociated(token, rc);
    }

    /**
     * @dev Batch dissociates multiple HTS tokens with the specified account
     * @param account The account to dissociate the tokens with
     * @param tokens Array of HTS token addresses
     */
    function _batchDissociateTokens(address account, address[] memory tokens) internal returns (int64 rc) {
        if (tokens.length == 0) revert InvalidLength();

        rc = IHederaTokenService(HederaConstants.HTS_ADDRESS).dissociateTokens(account, tokens);
        if (rc != HederaConstants.RC_SUCCESS && rc != HederaConstants.RC_TOKEN_NOT_ASSOCIATED_TO_ACCOUNT)
            revert HTSAssociationFailed(rc);

        emit TokensDissociated(tokens, rc);
    }
}
