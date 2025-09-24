# Credit Name Service

A decentralized domain name service on Credit Testnet. Register and manage your own .ctc domains with a beautiful, modern interface, seamless wallet integration, and a fully functional marketplace.

## 🌟 Features

### **Domain Registration System**
- **.ctc Domains**: Register unique domains with .ctc extension
- **Instant Registration**: 1000 tCTC for 1-year domain registration
- **Availability Check**: Real-time domain availability verification
- **Blockchain Integration**: Secure registration via smart contracts on Credit Testnet

### **Domain Marketplace**
- **List Domains**: List your domains for sale with fixed pricing
- **Buy Domains**: Purchase domains directly from other users
- **Listing Fees**: 100 tCTC fee to list domains on marketplace
- **Secure Transactions**: Smart contract-based escrow system
- **Search & Filter**: Find domains by name or seller address
- **Navigation System**: Browse listings with smooth pagination

### **Domain Transfer System**
- **Direct Transfer**: Instantly transfer domains to another wallet (100 tCTC fee)
- **Marketplace Integration**: Automatic marketplace listing ownership updates
- **Cross-Wallet Support**: Transfer between different wallet types
- **Secure Transactions**: Blockchain-verified ownership transfers

### **Wallet Integration**
- **RainbowKit Integration**: Modern wallet connection with multiple wallet support
- **Credit Testnet**: Automatic network detection and validation
- **Connection Status**: Real-time wallet connection feedback
- **Network Validation**: Ensures users are on Credit Testnet (Chain ID: 102031)

### **Modern UI/UX**
- **Glassmorphism Design**: Frosted glass effects with backdrop blur
- **Dynamic Background**: Animated wave effects using HTML Canvas
- **Responsive Design**: Perfect performance on all screen sizes
- **Smooth Animations**: Fluid transitions and micro-interactions
- **Loading System**: Professional loading screens and state management
- **Navigation Controls**: Arrow-based navigation for large lists

### **Profile Management**
- **Domain Portfolio**: View all owned domains with status indicators
- **Listing Status**: See which domains are listed on marketplace
- **Transfer History**: Complete history of sent and received transfers
- **Compact Views**: Optimized display with pagination for large collections

## 🛠️ Technologies

### **Frontend Framework**
- **Next.js 15**: React framework with App Router
- **TypeScript**: Full type safety and development experience
- **Styled Components**: Component-scoped CSS-in-JS styling
- **React Icons**: Beautiful icon library

### **Blockchain Integration**
- **Credit Testnet**: Built specifically for Credit Testnet (Chain ID: 102031)
- **Hardhat**: Smart contract development and deployment
- **Ethers.js v6**: Latest Ethereum library for blockchain interactions
- **Smart Contracts**: Solidity-based domain registry and marketplace
- **Wagmi**: React hooks for Ethereum integration

### **Database & Backend**
- **Supabase**: PostgreSQL database with real-time features
- **Row Level Security**: Database-level security policies
- **Real-time Sync**: Live updates between frontend and database

### **Wallet Support**
- **RainbowKit**: Modern wallet connection library
- **MetaMask**: Browser extension wallet
- **WalletConnect**: Mobile and desktop wallet connectivity
- **Multiple Wallets**: Support for 50+ wallet providers

### **Design & Animation**
- **HTML Canvas**: Dynamic background wave animation
- **Simplex Noise**: Procedural wave generation algorithm
- **Glassmorphism**: Modern frosted glass UI effects
- **Custom Notifications**: Beautiful toast notification system

### **Development Tools**
- **Hardhat**: Smart contract compilation and deployment
- **ESLint**: Code quality and consistency
- **Git**: Version control with proper .gitignore setup

## 📁 Project Structure

```
src/
├── app/                    # Next.js App Router
│   ├── layout.tsx         # Root layout with RainbowKit providers
│   ├── page.tsx           # Main application with all features
│   └── globals.css        # Global styles
├── components/            # Reusable UI components
│   ├── ConfirmationModal.tsx    # Confirmation dialogs
│   ├── DomainTransfer.tsx       # Domain transfer modal
│   ├── CreateListingModal.tsx   # Marketplace listing creation
│   ├── MarketplaceListings.tsx  # Marketplace display component
│   └── Notification.tsx         # Toast notification system
├── contexts/              # React Context providers
│   └── WalletContext.tsx  # Legacy wallet state management
└── lib/                   # Utility libraries
    ├── contract.ts        # Domain registry contract interactions
    ├── marketplaceContract.ts # Marketplace contract interactions
    ├── marketplace.ts     # Marketplace service layer
    └── supabase.ts        # Database service layer

contracts/                 # Smart contracts
├── CreditNameService.sol      # Main domain registry contract
└── CreditNameMarketplace.sol  # Marketplace contract for domain trading

scripts/                   # Deployment and utility scripts
├── deploy-credit.js       # Deploy contracts to Credit Testnet
├── check-contract-balance.js # Check contract balances and earnings
├── withdraw-funds.js      # Withdraw accumulated fees
├── sync-marketplace-ownership.js # Fix marketplace ownership issues
└── debug-marketplace.js  # Debug marketplace configuration

public/
├── Logo2.png             # Application logo
└── favicon.ico           # Browser favicon
```

## 🎨 Design System

### **Color Palette**
- **Primary**: Green gradients (#22c55e, #065f46)
- **Background**: Dark theme with animated wave effects
- **Text**: White and light gray for readability
- **Status Colors**: Green for active/available, red for expired/taken, blue for listed

### **Typography**
- **Headers**: Bold, gradient text effects
- **Body Text**: Clean, readable fonts
- **Interactive Elements**: Highlighted with color and weight

### **Components**
- **Glass Cards**: Frosted glass with backdrop blur
- **Search Box**: Focused input with domain extension
- **Buttons**: Gradient backgrounds with hover animations
- **Navigation**: Bottom tab navigation

## 🚀 Installation

### **Prerequisites**
- Node.js 18 or higher
- npm or yarn package manager
- Web3 wallet (MetaMask, OKX, or WalletConnect compatible)
- Supabase account (for backend database)

### **Installation Steps**

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd umi-name-service
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment variables**
   ```bash
   cp .env.example .env.local
   ```
   
   Edit `.env.local` file:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_url_here
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key_here
   NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=your_walletconnect_project_id
   NEXT_PUBLIC_CREDIT_EXPLORER_URL=https://creditcoin-testnet.blockscout.com
   NEXT_PUBLIC_CREDIT_RPC_URL=https://rpc.cc3-testnet.creditcoin.network
   NEXT_PUBLIC_CREDIT_CHAIN_ID=102031
   NEXT_PUBLIC_CREDIT_CONTRACT_ADDRESS=deployed_name_service_address
   NEXT_PUBLIC_MARKETPLACE_CONTRACT_ADDRESS=deployed_marketplace_address
   PRIVATE_KEY=your_wallet_private_key_for_deployment
   CONTRACT_OWNER_ADDRESS=your_contract_owner_address
   ```

4. **Set up Supabase database**
   - Create a new project in Supabase dashboard
   - Run SQL commands from `docs/supabase-schema.sql`
   - Enable RLS (Row Level Security) policies

5. **Deploy smart contracts (optional)**
   ```bash
   # Compile contracts
   npx hardhat compile
   
   # Deploy to Credit Testnet
   npx hardhat run scripts/deploy-credit.js --network creditTestnet
   ```

6. **Start development server**
   ```bash
   npm run dev
   ```

7. **Open in browser**
   ```
   http://localhost:3000
   ```

### **Supabase Setup**

1. **Create Supabase Project**
   - Go to [supabase.com](https://supabase.com)
   - Create a new project
   - Get project URL and anon key

2. **Set up Database Schema**
   - Open Supabase SQL Editor
   - Copy content from `docs/supabase-schema.sql`
   - Execute the SQL commands

3. **Verify RLS Policies**
   - Check policies in Authentication > Policies section
   - Add policies manually if needed

## 🔧 Configuration

### **Wallet Setup**
1. Install a compatible Web3 wallet (MetaMask recommended)
2. Add Credit Testnet to your wallet:
   - **Network Name**: Credit Testnet
   - **RPC URL**: https://rpc.cc3-testnet.creditcoin.network
   - **Chain ID**: 102031
   - **Currency Symbol**: CTC
   - **Block Explorer**: https://creditcoin-testnet.blockscout.com

### **Network Requirements**
- The application works on Credit Testnet (Chain ID: 102031)
- RainbowKit handles network switching automatically
- Users will be prompted to switch if on wrong network

### **Smart Contracts**
- **Name Service**: Domain registration and management
- **Marketplace**: Domain trading and listings
- **Network**: Credit Testnet
- **Registration Fee**: 1000 tCTC per domain per year
- **Transfer Fee**: 100 tCTC per transfer
- **Listing Fee**: 100 tCTC per marketplace listing
- **Owner**: Contract owner can withdraw accumulated fees

## 📱 Usage

### **Registering a Domain**
1. **Connect Wallet**: Use RainbowKit to connect your preferred wallet
2. **Search Domain**: Enter your desired domain name in the search box
3. **Check Availability**: Click "Search" to check if the domain is available
4. **Register**: If available, click "Register Domain" and confirm the transaction
5. **Pay Fee**: Pay 1000 tCTC for 1 year registration

### **Managing Domains**
1. **View Profile**: Click the "Profile" tab in bottom navigation
2. **Domain List**: See all your registered domains with navigation controls
3. **Transfer Domains**: Click transfer button to send domains to other wallets (100 tCTC fee)
4. **List for Sale**: Click list button to put domains on marketplace (100 tCTC fee)
5. **Status Check**: Monitor active/expired and listing status

### **Domain Transfer**
1. **Select Domain**: Choose domain from your profile
2. **Enter Recipient**: Input recipient wallet address
3. **Pay Fee**: Transfer requires 100 tCTC fee
4. **Sign Transfer**: Sign the transfer transaction
5. **Automatic Updates**: Domain ownership and marketplace listings update automatically

### **Marketplace Trading**
1. **Browse Market**: Click "Market" tab to see available domains
2. **Search Domains**: Use search to find specific domains or sellers
3. **Buy Domains**: Click "Buy Now" to purchase listed domains
4. **Your Listings**: See "Your Listing" for domains you've listed

### **Transfer History**
1. **View History**: Click "History" tab to see all transfers
2. **Sent/Received**: See transfers you've sent and received with navigation
3. **Transaction Links**: Click to view on blockchain explorer
4. **Status Tracking**: Monitor transfer completion status

### **Wallet Connection**
1. **Multiple Options**: Choose from MetaMask, OKX Wallet, or WalletConnect
2. **Network Check**: App automatically verifies Umi Devnet connection
3. **Auto Switch**: Prompts to switch to Umi Devnet if needed
4. **Disconnect**: Easy wallet disconnection from profile

## 🌟 Key Features

### **Domain System**
- **.ctc Extension**: All domains end with .ctc
- **1 Year Registration**: Domains are registered for 1 year periods
- **1000 tCTC Fee**: Fixed registration fee in tCTC
- **Transfer Fee**: 100 tCTC for domain transfers
- **Instant Search**: Real-time availability checking

### **User Interface**
- **Clean Design**: Minimalist, focused interface
- **Visual Feedback**: Clear status indicators and animations
- **Responsive**: Works on desktop, tablet, and mobile
- **Accessibility**: Keyboard navigation and screen reader support

### **Blockchain Integration**
- **Credit Testnet**: Native integration with Credit Testnet
- **Smart Contracts**: Decentralized domain registry and marketplace
- **RainbowKit**: Modern wallet connectivity
- **Transaction Handling**: Smooth transaction flow with proper error handling

## 🔮 Future Enhancements

### **Planned Features**
- **Domain Renewal**: Extend domain registration periods
- **Auction System**: Auction-based domain sales
- **Subdomain Support**: Create subdomains for registered domains
- **Bulk Registration**: Register multiple domains at once
- **Domain Analytics**: Usage statistics and insights
- **Offer System**: Make offers on unlisted domains

### **Technical Improvements**
- **IPFS Integration**: Decentralized content hosting
- **Cross-chain Support**: Multi-network domain resolution
- **Mobile App**: React Native mobile application
- **Advanced Filtering**: Filter by price, age, length
- **Gas Optimization**: Reduce transaction costs
- **Real-time Updates**: WebSocket-based live updates

### **UI/UX Enhancements**
- **Theme Switching**: Dark/Light mode toggle
- **Internationalization**: Multi-language support
- **Advanced Animations**: More sophisticated transitions
- **Customization**: Personalized user preferences
- **Improved Notifications**: Enhanced notification system

## 🤝 Contributing

We welcome contributions to Umi Name Service! Here's how you can help:

1. **Fork the Repository**: Create your own fork
2. **Create Feature Branch**: `git checkout -b feature/amazing-feature`
3. **Make Changes**: Implement your feature or fix
4. **Add Tests**: Ensure your changes are tested
5. **Commit Changes**: `git commit -m 'Add amazing feature'`
6. **Push to Branch**: `git push origin feature/amazing-feature`
7. **Open Pull Request**: Submit your changes for review

### **Development Guidelines**
- Follow TypeScript best practices
- Use styled-components for styling
- Maintain component reusability
- Add proper documentation and comments
- Test on multiple browsers and devices

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Credit Network**: Blockchain infrastructure and development support
- **RainbowKit**: Modern wallet connection library
- **WalletConnect**: Multi-wallet connectivity protocol
- **Next.js Team**: Amazing React framework
- **Styled Components**: CSS-in-JS styling solution
- **Supabase**: Backend-as-a-Service platform

## 📞 Support

For support, questions, or feedback:

- **GitHub Issues**: [Report bugs or request features](https://github.com/your-repo/issues)
- **Documentation**: [Credit Network Docs](https://docs.creditcoin.org)
- **Community**: Join our Discord or Telegram communities

## 🌐 Links

- **Credit Network**: [https://creditcoin.org](https://creditcoin.org)
- **Credit Testnet Explorer**: [https://creditcoin-testnet.blockscout.com](https://creditcoin-testnet.blockscout.com)
- **RPC Endpoint**: [https://rpc.cc3-testnet.creditcoin.network](https://rpc.cc3-testnet.creditcoin.network)

## 📊 Project Status

- ✅ **Smart Contracts**: Deployed and verified on Credit Testnet
- ✅ **Frontend**: Complete with all core features
- ✅ **Database**: Supabase integration with RLS policies
- ✅ **Wallet Integration**: RainbowKit with 50+ wallet support
- ✅ **Domain Registration**: Fully functional (1000 tCTC)
- ✅ **Domain Transfer**: Complete transfer system (100 tCTC)
- ✅ **Domain Marketplace**: Buy and sell domains with smart contracts
- ✅ **Transfer History**: View all transfer activity with navigation
- ✅ **Profile Management**: Compact domain management with status indicators
- ✅ **Search & Navigation**: Advanced search and pagination systems
- ✅ **Security**: No hardcoded private keys, environment-based configuration

---

**Built with ❤️ for the Credit Network ecosystem**

*Register your .ctc domain today and trade on the decentralized marketplace!*