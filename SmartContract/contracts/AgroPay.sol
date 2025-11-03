// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/* --------- Interfaz ERC20 a nivel de archivo (fuera del contrato) --------- */
interface IERC20 {
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
}

/* ------------------------------- Contrato ---------------------------------- */
contract AgroEscrow {
    // ===== Tipos =====
    enum Status { None, Created, Funded, Delivered, Refunded }

    struct Deal {
        address buyer;        // quien paga
        address seller;       // quien vende
        address token;        // address(0) = ETH; otro = ERC20
        uint256 price;        // precio total (pago)
        uint64  deadline;     // fecha límite para confirmar entrega
        Status  status;       // estado actual
        string  commodity;    // "Maíz"
        uint256 quantity;     // en kilos (ej. 15000 para 15 toneladas)
    }

    uint256 public nextDealId = 1;
    mapping(uint256 => Deal) public deals; // dealId => Deal

    // ===== Eventos =====
    event DealCreated(
        uint256 indexed dealId,
        address indexed buyer,
        address indexed seller,
        address token,
        uint256 price,
        uint64 deadline,
        string commodity,
        uint256 quantityKg
    );
    event Funded(uint256 indexed dealId, uint256 amount);
    event Delivered(uint256 indexed dealId);
    event Released(uint256 indexed dealId, uint256 amount, address to);
    event Refunded(uint256 indexed dealId, uint256 amount, address to);

    // ===== Utils =====
    function _pull(address token, address from, uint256 amount) internal {
        if (token == address(0)) {
            require(msg.value == amount, "BAD_ETH_AMOUNT");
        } else {
            require(IERC20(token).transferFrom(from, address(this), amount), "ERC20_PULL_FAIL");
        }
    }

    function _pay(address token, address to, uint256 amount) internal {
        if (amount == 0) return;
        if (token == address(0)) {
            (bool ok, ) = to.call{value: amount}("");
            require(ok, "ETH_SEND_FAIL");
        } else {
            require(IERC20(token).transfer(to, amount), "ERC20_SEND_FAIL");
        }
    }

    // ===== Crear trato =====
    function createDeal(
        address _buyer,
        address _seller,
        string calldata _commodity,
        uint256 _quantityKg,
        uint256 _price,
        uint64 _deadline,
        address _token
    ) external returns (uint256 dealId) {
        require(_buyer != address(0) && _seller != address(0), "ADDR_0");
        require(_price > 0 && _quantityKg > 0, "ZERO_VAL");
        require(_deadline > block.timestamp, "BAD_DEADLINE");

        dealId = nextDealId++;
        deals[dealId] = Deal({
            buyer: _buyer,
            seller: _seller,
            token: _token,
            price: _price,
            deadline: _deadline,
            status: Status.Created,
            commodity: _commodity,
            quantity: _quantityKg
        });

        emit DealCreated(dealId, _buyer, _seller, _token, _price, _deadline, _commodity, _quantityKg);
    }

    // ===== Depósito del comprador =====
    function fund(uint256 dealId) external payable {
        Deal storage d = deals[dealId];
        require(d.status == Status.Created, "BAD_STATUS");
        require(msg.sender == d.buyer, "ONLY_BUYER");
        _pull(d.token, msg.sender, d.price);
        d.status = Status.Funded;
        emit Funded(dealId, d.price);
    }

    // ===== Confirmación de entrega (libera pago al vendedor) =====
    function confirmDelivery(uint256 dealId) external {
        Deal storage d = deals[dealId];
        require(d.status == Status.Funded, "BAD_STATUS");
        require(msg.sender == d.buyer, "ONLY_BUYER");
        require(block.timestamp <= d.deadline, "AFTER_DEADLINE");
        d.status = Status.Delivered;
        emit Delivered(dealId);
        _pay(d.token, d.seller, d.price);
        emit Released(dealId, d.price, d.seller);
    }

    // ===== Reembolso por no entrega =====
    function refundAfterDeadline(uint256 dealId) external {
        Deal storage d = deals[dealId];
        require(d.status == Status.Funded, "BAD_STATUS");
        require(block.timestamp > d.deadline, "BEFORE_DEADLINE");
        require(msg.sender == d.buyer, "ONLY_BUYER");
        d.status = Status.Refunded;
        _pay(d.token, d.buyer, d.price);
        emit Refunded(dealId, d.price, d.buyer);
    }

    // ===== Lecturas =====
    function getDeal(uint256 dealId) external view returns (Deal memory) {
        return deals[dealId];
    }

    receive() external payable {}
}

