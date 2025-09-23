import type { Metadata } from "next";
import "./globals.css";
import { WalletProvider } from "@/contexts/WalletContext";

export const metadata: Metadata = {
  title: "Credit Name Service",
  description: "Get your own domain on Credit Testnet",
  icons: {
    icon: '/icon.png',
    shortcut: '/favicon.ico',
    apple: '/icon.png',
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <head>
        <link rel="icon" type="image/x-icon" href="/favicon.ico" />
        <link rel="icon" type="image/png" sizes="32x32" href="/icon.png" />
        <link rel="apple-touch-icon" href="/icon.png" />
        <script
          dangerouslySetInnerHTML={{
            __html: `
              // Hide body content immediately to prevent HTML flash
              document.documentElement.style.opacity = '0';
              
              // Hide loading screen after 2 seconds
              setTimeout(function() {
                const loading = document.getElementById('loading-screen');
                if (loading) {
                  loading.style.display = 'none';
                }
                document.documentElement.style.opacity = '1';
                document.body.classList.add('loaded');
              }, 2000);
              
            `,
          }}
        />
      </head>
      <body className="font-sans antialiased">
        <div id="loading-screen" style={{
          position: 'fixed',
          top: '0',
          left: '0',
          width: '100vw',
          height: '100vh',
          backgroundColor: '#0f0f23',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: '999999',
          color: 'white',
          fontFamily: 'Arial, sans-serif'
        }}>
          <div style={{ 
            marginBottom: '60px',
            marginTop: '-20px',
            animation: 'pulse 2s ease-in-out infinite'
          }}>
              <img 
              src="/unslogo.png" 
              alt="Credit Name Service" 
              style={{ 
                height: '60px', 
                width: 'auto',
                filter: 'brightness(1.5)'
              }} 
            />
          </div>
          <div style={{
            width: '50px',
            height: '50px',
            border: '3px solid rgba(255, 255, 255, 0.1)',
            borderTop: '3px solid #3b82f6',
            borderRadius: '50%',
            animation: 'spin 1s linear infinite',
            marginBottom: '24px'
          }}></div>
          <h2 style={{
            fontSize: '1.5rem',
            fontWeight: '600',
            color: '#3b82f6',
            margin: '0 0 8px 0',
            textAlign: 'center'
          }}>Credit Name Service</h2>
          <p style={{
            fontSize: '1rem',
            color: 'rgba(255, 255, 255, 0.7)',
            margin: '0',
            textAlign: 'center',
            maxWidth: '300px'
          }}>Loading your Credit Name Service...</p>
        </div>
        <WalletProvider>
          {children}
        </WalletProvider>
      </body>
    </html>
  );
}
