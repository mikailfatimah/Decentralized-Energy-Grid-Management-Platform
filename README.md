# Decentralized Energy Grid Management Platform

A blockchain-based platform enabling peer-to-peer energy trading and distributed energy resource management through smart contracts and IoT integration.

## Overview

The Decentralized Energy Grid Management Platform revolutionizes energy distribution by enabling direct peer-to-peer trading between prosumers while maintaining grid stability through automated management of distributed energy resources (DERs).

## Core Features

### Energy Trading System
- Real-time energy trading marketplace
- Automated price discovery mechanism
- Smart contract-based settlements
- Dynamic pricing based on supply/demand
- Flexible trading periods (hourly/daily/weekly)

### Grid Management
- Real-time monitoring of grid stability
- Automated load balancing
- Demand response management
- Voltage regulation
- Frequency control

### Smart Meter Integration
```solidity
interface ISmartMeter {
    struct MeterReading {
        uint256 timestamp;
        uint256 consumption;
        uint256 production;
        uint256 gridFrequency;
        uint256 voltage;
    }

    function submitReading(MeterReading calldata reading) external;
    function getLatestReading() external view returns (MeterReading memory);
    function getDailyProduction() external view returns (uint256);
    function getDailyConsumption() external view returns (uint256);
}
```

## Technical Architecture

### Blockchain Layer
```
├── Smart Contracts
│   ├── EnergyTrading.sol
│   ├── GridManagement.sol
│   ├── SmartMeter.sol
│   ├── EnergyAssetNFT.sol
│   └── Settlement.sol
├── Oracle Network
│   ├── PriceOracle.sol
│   ├── WeatherOracle.sol
│   └── GridOracle.sol
└── Token Contracts
    ├── EnergyToken.sol
    └── GovernanceToken.sol
```

### Application Layer
```
├── Backend Services
│   ├── Trading Engine
│   ├── Grid Management Service
│   ├── Smart Meter Integration
│   ├── Settlement Service
│   └── Analytics Engine
└── Frontend Applications
    ├── Prosumer Dashboard
    ├── Grid Operator Interface
    ├── Trading Platform
    └── Analytics Dashboard
```

## Smart Contract Specifications

### EnergyTrading.sol
```solidity
interface IEnergyTrading {
    struct Order {
        address trader;
        uint256 amount;
        uint256 price;
        uint256 expiry;
        OrderType orderType;
        OrderStatus status;
    }

    enum OrderType { BUY, SELL }
    enum OrderStatus { ACTIVE, FILLED, CANCELLED }

    function createOrder(
        uint256 amount,
        uint256 price,
        uint256 expiry,
        OrderType orderType
    ) external returns (uint256 orderId);

    function cancelOrder(uint256 orderId) external;
    function matchOrders(uint256 buyOrderId, uint256 sellOrderId) external;
    function settleTransaction(uint256 transactionId) external;
}
```

## Getting Started

### Prerequisites
- Node.js v16+
- MongoDB v4.4+
- Smart meter API credentials
- Grid operator permissions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-org/energy-grid.git
cd energy-grid
```

2. Install dependencies:
```bash
npm install
```

3. Configure environment:
```bash
cp .env.example .env
# Edit .env with required credentials
```

4. Deploy smart contracts:
```bash
npx hardhat run scripts/deploy.js --network <network>
```

## API Documentation

### Trading API
```
POST /api/v1/orders
GET /api/v1/orders/{id}
POST /api/v1/orders/{id}/cancel
GET /api/v1/trades
```

### Grid Management
```
GET /api/v1/grid/status
GET /api/v1/grid/demand
GET /api/v1/grid/supply
POST /api/v1/grid/balance
```

### Smart Meter Integration
```
POST /api/v1/meters/reading
GET /api/v1/meters/{id}/history
GET /api/v1/meters/{id}/production
GET /api/v1/meters/{id}/consumption
```

## Price Discovery Mechanism

### Variables Considered
- Current grid demand
- Available supply
- Time of day
- Weather conditions
- Grid stability metrics
- Historical pricing

### Price Calculation
```python
def calculate_energy_price(params):
    base_price = get_base_price()
    demand_factor = calculate_demand_impact(params.demand)
    supply_factor = calculate_supply_impact(params.supply)
    time_factor = calculate_time_impact(params.time)
    stability_factor = calculate_stability_impact(params.grid_metrics)
    
    return base_price * weighted_average([
        (demand_factor, 0.3),
        (supply_factor, 0.3),
        (time_factor, 0.2),
        (stability_factor, 0.2)
    ])
```

## Security Measures

### Smart Contract Security
- Multi-signature requirements
- Rate limiting
- Emergency shutdown mechanism
- Oracle validation
- Regular audits

### Grid Security
- Redundant systems
- Fallback mechanisms
- Attack detection
- Automated circuit breakers
- Data encryption

## NFT Implementation

### EnergyAssetNFT
- Represents energy production assets
- Tracks production history
- Stores maintenance records
- Manages asset permissions
- Enables fractional ownership

## Development Roadmap

### Phase 1: Foundation (Q2 2025)
- Core trading platform
- Basic grid management
- Smart meter integration

### Phase 2: Enhancement (Q3 2025)
- Advanced trading features
- Dynamic pricing
- Mobile app release

### Phase 3: Scaling (Q4 2025)
- Cross-grid trading
- AI/ML integration
- Advanced analytics

## License
This project is licensed under the MIT License - see LICENSE.md for details.

## Support
- Documentation: docs.energy-grid.com
- Email: support@energy-grid.com
- Technical Forum: forum.energy-grid.com
