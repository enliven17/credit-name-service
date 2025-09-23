"use client";

import React from 'react';
import { WagmiProvider, createConfig, http } from 'wagmi';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { RainbowKitProvider, darkTheme, getDefaultWallets } from '@rainbow-me/rainbowkit';
// Remove individual connector imports
import '@rainbow-me/rainbowkit/styles.css';

const CREDIT_CHAIN_ID = Number(process.env.NEXT_PUBLIC_CREDIT_CHAIN_ID || '102031');
const CREDIT_RPC_URL = process.env.NEXT_PUBLIC_CREDIT_RPC_URL || 'https://rpc.cc3-testnet.creditcoin.network';
const CREDIT_EXPLORER_URL = process.env.NEXT_PUBLIC_CREDIT_EXPLORER_URL || 'https://creditcoin-testnet.blockscout.com';

const creditTestnet = {
  id: CREDIT_CHAIN_ID,
  name: 'Creditcoin Testnet',
  nativeCurrency: { name: 'Creditcoin', symbol: 'CTC', decimals: 18 },
  rpcUrls: { default: { http: [CREDIT_RPC_URL] } },
  blockExplorers: { default: { name: 'Blockscout', url: CREDIT_EXPLORER_URL } },
} as const;

const { connectors } = getDefaultWallets({
  appName: 'Credit Name Service',
  projectId: process.env.NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID || '226b43b703188d269fb70d02c107c34e',
});

const config = createConfig({
  chains: [creditTestnet as any],
  connectors,
  transports: { [creditTestnet.id]: http(CREDIT_RPC_URL) },
  ssr: false,
});

const queryClient = new QueryClient();

export function RainbowProvider({ children }: { children: React.ReactNode }) {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider 
          theme={darkTheme({ accentColor: '#22c55e' })}
          modalSize="compact"
          initialChain={creditTestnet}
        >
          {children}
        </RainbowKitProvider>
      </QueryClientProvider>
    </WagmiProvider>
  );
}


