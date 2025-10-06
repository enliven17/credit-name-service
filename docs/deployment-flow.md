# Credit Name Service - Deployment Flow

## Development to Production Pipeline

```mermaid
flowchart TD
    subgraph "Development Environment"
        DEV_CODE[Local Development]
        DEV_TEST[Local Testing]
        DEV_CONTRACTS[Local Contract Testing]
    end
    
    subgraph "Testing Environment"
        TEST_DEPLOY[Deploy to Testnet]
        TEST_FRONTEND[Test Frontend]
        TEST_DB[Test Database]
        TEST_INTEGRATION[Integration Testing]
    end
    
    subgraph "Production Environment"
        PROD_CONTRACTS[Deploy Contracts]
        PROD_FRONTEND[Deploy Frontend]
        PROD_DB[Production Database]
        PROD_MONITOR[Monitoring]
    end
    
    DEV_CODE --> DEV_TEST
    DEV_TEST --> DEV_CONTRACTS
    DEV_CONTRACTS --> TEST_DEPLOY
    
    TEST_DEPLOY --> TEST_FRONTEND
    TEST_FRONTEND --> TEST_DB
    TEST_DB --> TEST_INTEGRATION
    
    TEST_INTEGRATION --> PROD_CONTRACTS
    PROD_CONTRACTS --> PROD_FRONTEND
    PROD_FRONTEND --> PROD_DB
    PROD_DB --> PROD_MONITOR
    
    style DEV_CODE fill:#22c55e
    style TEST_DEPLOY fill:#3b82f6
    style PROD_CONTRACTS fill:#8b5cf6
```

## Smart Contract Deployment Process

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant HH as Hardhat
    participant CT as Credit Testnet
    participant Explorer as Block Explorer
    
    Dev->>HH: Compile contracts
    HH->>HH: Generate artifacts
    Dev->>HH: Run deployment script
    HH->>CT: Deploy CreditNameService
    CT->>HH: Return contract address
    HH->>CT: Deploy CreditNameMarketplace
    CT->>HH: Return marketplace address
    HH->>CT: Link contracts (setMarketplace)
    CT->>HH: Confirm linking
    Dev->>Explorer: Verify contracts
    Explorer->>Dev: Contracts verified
    Dev->>Dev: Update environment variables
```

## Environment Configuration

```mermaid
flowchart TD
    subgraph "Environment Files"
        ENV_EXAMPLE[.env.example]
        ENV_LOCAL[.env.local]
        ENV_PROD[.env.production]
    end
    
    subgraph "Configuration Categories"
        SUPABASE_CONFIG[Supabase Configuration]
        BLOCKCHAIN_CONFIG[Blockchain Configuration]
        WALLET_CONFIG[Wallet Configuration]
        CONTRACT_CONFIG[Contract Addresses]
    end
    
    subgraph "Deployment Targets"
        LOCAL[Local Development]
        TESTNET[Credit Testnet]
        MAINNET[Credit Mainnet]
    end
    
    ENV_EXAMPLE --> ENV_LOCAL
    ENV_LOCAL --> LOCAL
    
    ENV_PROD --> TESTNET
    ENV_PROD --> MAINNET
    
    SUPABASE_CONFIG --> ENV_LOCAL
    BLOCKCHAIN_CONFIG --> ENV_LOCAL
    WALLET_CONFIG --> ENV_LOCAL
    CONTRACT_CONFIG --> ENV_LOCAL
    
    style ENV_LOCAL fill:#22c55e
    style TESTNET fill:#3b82f6
    style MAINNET fill:#ef4444
```

## Database Migration Flow

```mermaid
flowchart TD
    subgraph "Schema Development"
        SCHEMA_DESIGN[Design Database Schema]
        SQL_FILES[Create SQL Files]
        LOCAL_TEST[Test Locally]
    end
    
    subgraph "Supabase Setup"
        CREATE_PROJECT[Create Supabase Project]
        RUN_MIGRATIONS[Run SQL Migrations]
        SETUP_RLS[Configure RLS Policies]
        TEST_QUERIES[Test Database Queries]
    end
    
    subgraph "Production Database"
        PROD_SUPABASE[Production Supabase]
        BACKUP[Database Backups]
        MONITORING[Query Monitoring]
    end
    
    SCHEMA_DESIGN --> SQL_FILES
    SQL_FILES --> LOCAL_TEST
    LOCAL_TEST --> CREATE_PROJECT
    
    CREATE_PROJECT --> RUN_MIGRATIONS
    RUN_MIGRATIONS --> SETUP_RLS
    SETUP_RLS --> TEST_QUERIES
    
    TEST_QUERIES --> PROD_SUPABASE
    PROD_SUPABASE --> BACKUP
    PROD_SUPABASE --> MONITORING
    
    style SCHEMA_DESIGN fill:#22c55e
    style CREATE_PROJECT fill:#8b5cf6
    style PROD_SUPABASE fill:#3b82f6
```

## Frontend Deployment Pipeline

```mermaid
flowchart TD
    subgraph "Build Process"
        BUILD_START[Start Build]
        INSTALL_DEPS[Install Dependencies]
        TYPE_CHECK[TypeScript Check]
        BUILD_APP[Build Next.js App]
        OPTIMIZE[Optimize Assets]
    end
    
    subgraph "Deployment Platforms"
        VERCEL[Vercel Deployment]
        NETLIFY[Netlify Deployment]
        CUSTOM[Custom Server]
    end
    
    subgraph "Post-Deployment"
        HEALTH_CHECK[Health Check]
        SMOKE_TEST[Smoke Tests]
        MONITORING[Performance Monitoring]
        ALERTS[Error Alerts]
    end
    
    BUILD_START --> INSTALL_DEPS
    INSTALL_DEPS --> TYPE_CHECK
    TYPE_CHECK --> BUILD_APP
    BUILD_APP --> OPTIMIZE
    
    OPTIMIZE --> VERCEL
    OPTIMIZE --> NETLIFY
    OPTIMIZE --> CUSTOM
    
    VERCEL --> HEALTH_CHECK
    NETLIFY --> HEALTH_CHECK
    CUSTOM --> HEALTH_CHECK
    
    HEALTH_CHECK --> SMOKE_TEST
    SMOKE_TEST --> MONITORING
    MONITORING --> ALERTS
    
    style BUILD_START fill:#22c55e
    style VERCEL fill:#3b82f6
    style HEALTH_CHECK fill:#8b5cf6
```