# Umi Name Service

A decentralized domain name service on Umi Network. Register and manage your own .umi domains with a beautiful, modern interface and seamless wallet integration.

## 🌟 Features

### **Domain Registration System**
- **.umi Domains**: Register unique domains with .umi extension
- **Instant Registration**: 0.05 ETH for 1-year domain registration
- **Availability Check**: Real-time domain availability verification
- **Blockchain Integration**: Secure registration via smart contracts on Umi Devnet

### **Domain Transfer System**
- **Direct Transfer**: Instantly transfer domains to another wallet
- **Signature Transfer**: Create transfer signatures for recipient claiming
- **Cross-Wallet Support**: Transfer between different wallet types
- **Secure Signing**: Cryptographic signatures for safe transfers

### **Wallet Integration**
- **Multi-Wallet Support**: MetaMask, OKX Wallet, WalletConnect
- **Umi Devnet**: Automatic network switching and validation
- **Connection Status**: Real-time wallet connection feedback
- **Network Validation**: Ensures users are on the correct network

### **Modern UI/UX**
- **Glassmorphism Design**: Frosted glass effects with backdrop blur
- **Dynamic Background**: Animated wave effects using HTML Canvas
- **Responsive Design**: Perfect performance on all screen sizes
- **Smooth Animations**: Fluid transitions and micro-interactions

### **Transfer History**
- **Complete History**: View all sent and received domain transfers
- **Transaction Links**: Direct links to blockchain explorer
- **Status Tracking**: Monitor transfer completion status
- **Direction Indicators**: Clear sent/received visual indicators

## 🛠️ Technologies

### **Frontend Framework**
- **Next.js 15**: React framework with App Router
- **TypeScript**: Full type safety and development experience
- **Styled Components**: Component-scoped CSS-in-JS styling
- **React Icons**: Beautiful icon library

### **Blockchain Integration**
- **Umi Network**: Built specifically for Umi Devnet (Chain ID: 42069)
- **Hardhat**: Smart contract development and deployment
- **Ethers.js**: Ethereum library for blockchain interactions
- **Smart Contracts**: Solidity-based domain registry

### **Database & Backend**
- **Supabase**: PostgreSQL database with real-time features
- **Row Level Security**: Database-level security policies
- **Real-time Sync**: Live updates between frontend and database

### **Wallet Support**
- **MetaMask**: Browser extension wallet
- **OKX Wallet**: Multi-chain wallet support
- **WalletConnect**: Mobile and desktop wallet connectivity

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
│   ├── layout.tsx         # Root layout with providers
│   ├── page.tsx           # Main application page
│   └── globals.css        # Global styles
├── components/            # Reusable UI components
│   ├── ConfirmationModal.tsx  # Confirmation dialogs
│   ├── DomainTransfer.tsx     # Domain transfer modal
│   └── Notification.tsx       # Toast notification system
├── contexts/              # React Context providers
│   └── WalletContext.tsx  # Wallet state management
└── lib/                   # Utility libraries
    ├── contract.ts        # Smart contract interactions
    └── supabase.ts        # Database service layer

contracts/                 # Smart contracts
├── MinimalUmiNameService.sol  # Production contract
├── SimpleUmiNameService.sol   # Alternative implementation
└── UmiNameService.sol         # Full-featured contract

scripts/                   # Deployment and utility scripts
├── deploy-minimal.js      # Deploy production contract
├── check-balance.js       # Check contract balances
├── send-eth.js           # ETH transfer utility
└── simple-check.js       # Contract status checker

public/
├── Logo2.png             # Application logo
└── favicon.ico           # Browser favicon
```

## 🎨 Design System

### **Color Palette**
- **Primary**: Blue gradients (#3b82f6, #1e40af)
- **Background**: Dark theme with glassmorphism effects
- **Text**: White and light gray for readability
- **Status Colors**: Green for available, red for taken

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
   NEXT_PUBLIC_UMI_CONTRACT_ADDRESS=0x9D5F12DBe903A0741F675e4Aa4454b2F7A010aB4
   PRIVATE_KEY=your_wallet_private_key_for_deployment
   CONTRACT_OWNER_ADDRESS=your_contract_owner_address
   TEST_RECIPIENT_ADDRESS=test_recipient_wallet_address
   ```

4. **Set up Supabase database**
   - Create a new project in Supabase dashboard
   - Run SQL commands from `docs/supabase-schema.sql`
   - Enable RLS (Row Level Security) policies

5. **Deploy smart contract (optional)**
   ```bash
   # Compile contracts
   npx hardhat compile
   
   # Deploy to Umi Devnet
   npx hardhat run scripts/deploy-minimal.js --network devnet
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
2. Add Umi Devnet to your wallet:
   - **Network Name**: Umi Devnet
   - **RPC URL**: https://rpc.devnet.uminetwork.com
   - **Chain ID**: 42069
   - **Currency Symbol**: ETH
   - **Block Explorer**: https://explorer.devnet.uminetwork.com

### **Network Requirements**
- The application only works on Umi Devnet (Chain ID: 42069)
- Automatic network switching is implemented
- Users will be prompted to switch if on wrong network

### **Smart Contract**
- **Contract Address**: `0x9D5F12DBe903A0741F675e4Aa4454b2F7A010aB4`
- **Network**: Umi Devnet
- **Registration Fee**: 0.05 ETH per domain per year
- **Owner**: Contract owner can withdraw accumulated fees

## 📱 Usage

### **Registering a Domain**
1. **Connect Wallet**: Click "Connect Wallet" and choose your preferred wallet
2. **Search Domain**: Enter your desired domain name in the search box
3. **Check Availability**: Click "Search" to check if the domain is available
4. **Register**: If available, click "Register Domain" and confirm the transaction
5. **Pay Fee**: Pay 0.05 ETH for 1 year registration

### **Managing Domains**
1. **View Profile**: Click the "Profile" tab in bottom navigation
2. **Domain List**: See all your registered domains
3. **Transfer Domains**: Click transfer button to send domains to other wallets
4. **Status Check**: Monitor active/expired status

### **Domain Transfer**
1. **Select Domain**: Choose domain from your profile
2. **Enter Recipient**: Input recipient wallet address
3. **Sign Transfer**: Sign the transfer transaction
4. **Instant Transfer**: Domain immediately appears in recipient's profile

### **Transfer History**
1. **View History**: Click "History" tab to see all transfers
2. **Sent/Received**: See transfers you've sent and received
3. **Transaction Links**: Click to view on blockchain explorer
4. **Status Tracking**: Monitor transfer completion status

### **Wallet Connection**
1. **Multiple Options**: Choose from MetaMask, OKX Wallet, or WalletConnect
2. **Network Check**: App automatically verifies Umi Devnet connection
3. **Auto Switch**: Prompts to switch to Umi Devnet if needed
4. **Disconnect**: Easy wallet disconnection from profile

## 🌟 Key Features

### **Domain System**
- **.umi Extension**: All domains end with .umi
- **1 Year Registration**: Domains are registered for 1 year periods
- **0.05 ETH Fee**: Fixed registration fee in ETH
- **Instant Search**: Real-time availability checking

### **User Interface**
- **Clean Design**: Minimalist, focused interface
- **Visual Feedback**: Clear status indicators and animations
- **Responsive**: Works on desktop, tablet, and mobile
- **Accessibility**: Keyboard navigation and screen reader support

### **Blockchain Integration**
- **Umi Network**: Native integration with Umi Devnet
- **Smart Contracts**: Decentralized domain registry
- **Web3 Wallets**: Standard wallet connectivity
- **Transaction Handling**: Smooth transaction flow

## 🔮 Future Enhancements

### **Planned Features**
- **Domain Renewal**: Extend domain registration periods
- **Subdomain Support**: Create subdomains for registered domains
- **Domain Marketplace**: Buy and sell domains
- **Bulk Registration**: Register multiple domains at once
- **Domain Analytics**: Usage statistics and insights

### **Technical Improvements**
- **IPFS Integration**: Decentralized content hosting
- **ENS Compatibility**: Cross-chain domain resolution
- **Mobile App**: React Native mobile application
- **Advanced Search**: Filter and sort domain results
- **Gas Optimization**: Reduce transaction costs

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

- **Umi Network**: Blockchain infrastructure and development support
- **WalletConnect**: Multi-wallet connectivity protocol
- **Next.js Team**: Amazing React framework
- **Styled Components**: CSS-in-JS styling solution
- **Vercel**: Deployment and hosting platform

## 📞 Support

For support, questions, or feedback:

- **GitHub Issues**: [Report bugs or request features](https://github.com/your-repo/issues)
- **Documentation**: [Umi Network Docs](https://docs.uminetwork.com)
- **Community**: Join our Discord or Telegram communities

## 🌐 Links

- **Umi Network**: [https://uminetwork.com](https://uminetwork.com)
- **Umi Devnet Explorer**: [https://devnet.explorer.moved.network](https://devnet.explorer.moved.network)
- **Contract Address**: [0x9D5F12DBe903A0741F675e4Aa4454b2F7A010aB4](https://devnet.explorer.moved.network/address/0x9D5F12DBe903A0741F675e4Aa4454b2F7A010aB4)

## 📊 Project Status

- ✅ **Smart Contract**: Deployed and verified on Umi Devnet
- ✅ **Frontend**: Complete with all core features
- ✅ **Database**: Supabase integration with RLS policies
- ✅ **Wallet Integration**: MetaMask, OKX, WalletConnect support
- ✅ **Domain Registration**: Fully functional
- ✅ **Domain Transfer**: Complete transfer system
- ✅ **Transfer History**: View all transfer activity
- ✅ **Security**: No hardcoded private keys, environment-based configuration

---

**Built with ❤️ for the Umi Network ecosystem**

*Register your .umi domain today and be part of the decentralized web!*