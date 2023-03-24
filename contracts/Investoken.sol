// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20SnapshotUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/**
 * @title Investoken
 * @author Investoken
 * @notice Contract for token Investoken (IVTK)
 * @dev This contract represents the Investoken, an ERC20-compatible token with additional features.
 *
 * This contract includes the following extensions:
 * - Initializable: allows initialization of the contract state
 * - ERC20Upgradeable: implements the ERC20 standard with upgradeability
 * - ERC20BurnableUpgradeable: allows the burning of tokens
 * - ERC20SnapshotUpgradeable: allows the creation of snapshots of the token's state
 * - AccessControlEnumerableUpgradeable: allows for role-based access control with enumeration
 * - PausableUpgradeable: allows the pausing and unpausing of the contract
 * - ERC20PermitUpgradeable: allows for permit signatures for gasless transactions
 * - UUPSUpgradeable: allows for upgradeable contracts using the Unstructured Proxy pattern
 */
contract Investoken is
    Initializable,
    ERC20Upgradeable,
    ERC20BurnableUpgradeable,
    ERC20SnapshotUpgradeable,
    AccessControlEnumerableUpgradeable,
    PausableUpgradeable,
    ERC20PermitUpgradeable,
    UUPSUpgradeable
{
    bytes32 public constant SNAPSHOT_ROLE = keccak256("SNAPSHOT_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");

    /**
     * @dev Constructor function that disables initializers.
     */
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /**
     * @dev Initializes the contract with the given admin as the default admin and grants it all the roles.
     * @param admin The address of the admin.
     */
    function initialize(address admin) public initializer {
        __ERC20_init("Investoken", "IVTK");
        __ERC20Burnable_init();
        __ERC20Snapshot_init();
        __AccessControlEnumerable_init();
        __Pausable_init();
        __ERC20Permit_init("Investoken");
        __UUPSUpgradeable_init();

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(SNAPSHOT_ROLE, admin);
        _grantRole(PAUSER_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);
        _grantRole(UPGRADER_ROLE, admin);
    }

    /**
     * @dev Creates a snapshot of the current token state, which can later be used for restoring the state.
     *      This function can only be called by an address with the SNAPSHOT_ROLE.
     */
    function snapshot() external onlyRole(SNAPSHOT_ROLE) {
        _snapshot();
    }

    /**
     * @dev Pauses the token transfers and approvals.
     *      This function can only be called by an address with the PAUSER_ROLE.
     */
    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @dev Unpauses the token transfers and approvals.
     *      This function can only be called by an address with the PAUSER_ROLE.
     */
    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /**
     * @dev Mints new tokens and sends them to the specified address.
     *      Only callable by accounts with the MINTER_ROLE.
     * @param to The address to send the new tokens to.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        if (paused()) {
            _unpause();
            _mint(to, amount);
            _pause();
        } else {
            _mint(to, amount);
        }
    }

    /**
     * @dev Hook function that is called before any token transfer.
     *      Overrides the _beforeTokenTransfer function from ERC20Upgradeable and ERC20SnapshotUpgradeable.
     *      The function checks that the contract is not paused.
     * @param from The address tokens are transferred from.
     * @param to The address tokens are transferred to.
     * @param amount The amount of tokens being transferred.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )
        internal
        override(ERC20Upgradeable, ERC20SnapshotUpgradeable)
        whenNotPaused
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    /**
     * @dev Overrides the _authorizeUpgrade function from UUPSUpgradeable.
     *      Only callable by accounts with the UPGRADER_ROLE.
     * @param newImplementation The address of the new implementation contract.
     */
    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyRole(UPGRADER_ROLE) {}
}
