# Credit Name Service - Smart Contract Architecture

## Contract Interaction Diagram

```mermaid
graph TB
    subgraph "User Interactions"
        USER[User Wallet]
        FRONTEND[Frontend App]
    end
    
    subgraph "Smart Contracts"
        CNS[CreditNameService]
        CMP[CreditNameMarketplace]
    end
    
    subgraph "Contract Functions"
        subgraph "CreditNameService Functions"
            REG[register()]
            TRANS[transfer()]
            RENEW[renew()]
            OWNER[ownerOf()]
            MARKET_TRANS[marketTransfer()]
        end
        
        subgraph "CreditNameMarketplace Functions"
            LIST[list()]
            UNLIST[unlist()]
            BUY[buy()]
            WITHDRAW[withdraw()]
        end
    end
    
    USER --> FRONTEND
    FRONTEND --> CNS
    FRONTEND --> CMP
    
    CNS --> REG
    CNS --> TRANS
    CNS --> RENEW
    CNS --> OWNER
    CNS --> MARKET_TRANS
    
    CMP --> LIST
    CMP --> UNLIST
    CMP --> BUY
    CMP --> WITHDRAW
    
    CMP --> MARKET_TRANS
    
    style CNS fill:#3b82f6
    style CMP fill:#8b5cf6
    style USER fill:#22c55e
```

## Contract State Management

```mermaid
stateDiagram-v2
    [*] --> Available: Domain not registered
    Available --> Registered: register() + 1000 tCTC
    Registered --> Transferred: transfer() + 100 tCTC
    Transferred --> Registered: New owner
    Registered --> Expired: Time passes
    Expired --> Available: Domain expires
    Registered --> Listed: list() + 100 tCTC
    Listed --> Sold: buy() + price
    Sold --> Registered: New owner
    Listed --> Unlisted: unlist()
    Unlisted --> Registered: Remove from market
```

## Fee Structure Diagram

```mermaid
flowchart TD
    subgraph "Fee Types"
        REG_FEE[Registration Fee: 1000 tCTC]
        TRANS_FEE[Transfer Fee: 100 tCTC]
        LIST_FEE[Listing Fee: 100 tCTC]
    end
    
    subgraph "Fee Destinations"
        CNS_CONTRACT[CreditNameService Contract]
        CMP_CONTRACT[CreditNameMarketplace Contract]
        SELLER[Domain Seller]
    end
    
    subgraph "Owner Actions"
        WITHDRAW_CNS[Withdraw from NameService]
        WITHDRAW_CMP[Withdraw from Marketplace]
    end
    
    REG_FEE --> CNS_CONTRACT
    TRANS_FEE --> CNS_CONTRACT
    LIST_FEE --> CMP_CONTRACT
    
    CNS_CONTRACT --> WITHDRAW_CNS
    CMP_CONTRACT --> WITHDRAW_CMP
    
    BUY_PRICE[Domain Purchase Price] --> SELLER
    
    style REG_FEE fill:#22c55e
    style TRANS_FEE fill:#3b82f6
    style LIST_FEE fill:#8b5cf6
    style BUY_PRICE fill:#f59e0b
```

## Contract Security Model

```mermaid
flowchart TD
    subgraph "Access Control"
        OWNER[Contract Owner]
        MARKETPLACE[Marketplace Contract]
        USERS[Regular Users]
    end
    
    subgraph "Protected Functions"
        SET_MARKET[setMarketplace()]
        WITHDRAW_NS[withdraw() - NameService]
        WITHDRAW_MP[withdraw() - Marketplace]
        MARKET_TRANSFER[marketTransfer()]
    end
    
    subgraph "Public Functions"
        REGISTER[register()]
        TRANSFER[transfer()]
        LIST[list()]
        BUY[buy()]
        VIEW[View functions]
    end
    
    OWNER --> SET_MARKET
    OWNER --> WITHDRAW_NS
    OWNER --> WITHDRAW_MP
    
    MARKETPLACE --> MARKET_TRANSFER
    
    USERS --> REGISTER
    USERS --> TRANSFER
    USERS --> LIST
    USERS --> BUY
    USERS --> VIEW
    
    style OWNER fill:#ef4444
    style MARKETPLACE fill:#8b5cf6
    style USERS fill:#22c55e
```