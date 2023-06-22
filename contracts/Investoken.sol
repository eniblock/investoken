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
    bytes32 public constant TERMS_ROLE = keccak256("TERMS_ROLE");

    string public _a_Emetteur_du_token;
    string public _b_Descriptif_du_token;
    string public _c_Le_club_Investoken;
    string public _d_Processus_d_acquisition_des_biens;
    string public _e_Gestion_des_actifs;
    string public _f_Valeur_d_emission;
    string public _g_Emission_primaire_du_token;
    string public _h_Adhesion;
    string public _i_Niveau_d_adhesion;
    string public _j_Disponibilite;
    string public _k_Transfert_de_token;
    string public _l_Echanges;
    string public _m_Garantie;
    string public _n_Critere_du_cyberjeton;

    function setA_Emetteur_du_token(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _a_Emetteur_du_token = textutf8;
    }

    function setB_Descriptif_du_token(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _b_Descriptif_du_token = textutf8;
    }

    function setC_Le_club_Investoken(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _c_Le_club_Investoken = textutf8;
    }

    function setD_Processus_d_acquisition_des_biens(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _d_Processus_d_acquisition_des_biens = textutf8;
    }

    function setE_Gestion_des_actifs(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _e_Gestion_des_actifs = textutf8;
    }

    function setF_Valeur_d_emission(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _f_Valeur_d_emission = textutf8;
    }

    function setG_Emission_primaire_du_token(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _g_Emission_primaire_du_token = textutf8;
    }

    function setH_Adhesion(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _h_Adhesion = textutf8;
    }

    function setI_Niveau_d_adhesion(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _i_Niveau_d_adhesion = textutf8;
    }

    function setJ_Disponibilite(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _j_Disponibilite = textutf8;
    }

    function setK_Transfert_de_token(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _k_Transfert_de_token = textutf8;
    }

    function setL_Echanges(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _l_Echanges = textutf8;
    }

    function setM_Garantie(string memory textutf8) external onlyRole(TERMS_ROLE) {
       _m_Garantie = textutf8;
    }

    function setN_Critere_du_cyberjeton(string memory textutf8) external onlyRole(TERMS_ROLE) {
        _n_Critere_du_cyberjeton = textutf8;
    }

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
        _grantRole(TERMS_ROLE, admin);
    }

    /**
     * @notice This function return the number of decimals of the contract
     * @dev Returns the number of decimals used to get its user representation.
     */
    function decimals() public pure override returns (uint8) {
        return 4;
    }

    /**
     * @notice This function creates a snapshot of the current token state
     * @dev Creates a snapshot of the current token state, which can later be used for restoring the state.
     *      This function can only be called by an address with the SNAPSHOT_ROLE.
     */
    function snapshot() external onlyRole(SNAPSHOT_ROLE) {
        _snapshot();
    }

    /**
     * @notice This function pauses the token transfers and approvals
     * @dev Pauses the token transfers and approvals.
     *      This function can only be called by an address with the PAUSER_ROLE.
     */
    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @notice This function unpauses the token transfers and approvals
     * @dev Unpauses the token transfers and approvals.
     *      This function can only be called by an address with the PAUSER_ROLE.
     */
    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /**
     * @notice This function is used to mint new tokens and send them to the specified address
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
    ) internal override(ERC20Upgradeable, ERC20SnapshotUpgradeable) whenNotPaused {
        super._beforeTokenTransfer(from, to, amount);
    }

    /**
     * @dev Overrides the _authorizeUpgrade function from UUPSUpgradeable.
     *      Only callable by accounts with the UPGRADER_ROLE.
     * @param newImplementation The address of the new implementation contract.
     */
    function _authorizeUpgrade(address newImplementation) internal override onlyRole(UPGRADER_ROLE) {}

}
