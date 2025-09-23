"use client";

import { useState, useEffect } from 'react';
import styled from 'styled-components';
import { FaEthereum, FaClock, FaGavel, FaTag } from 'react-icons/fa';
import { marketplaceService, MarketplaceListing } from '@/lib/marketplace';
import { useAccount } from 'wagmi';

const ListingsContainer = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  padding: 20px 0;
`;

const ListingCard = styled.div`
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 20px;
  transition: all 0.3s ease;
  
  &:hover {
    border-color: rgba(255, 255, 255, 0.2);
    background: rgba(255, 255, 255, 0.12);
    transform: translateY(-2px);
  }
`;

const DomainName = styled.h3`
  font-size: 1.3rem;
  font-weight: 600;
  color: white;
  margin: 0 0 12px 0;
  display: flex;
  align-items: center;
  gap: 8px;
`;

const ListingInfo = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
`;

const Price = styled.div`
  font-size: 1.2rem;
  font-weight: 700;
  color: #22c55e;
  display: flex;
  align-items: center;
  gap: 6px;
`;

const ListingType = styled.div<{ type: string }>`
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.8rem;
  font-weight: 600;
  background: ${props => props.type === 'auction' ? 'rgba(255, 193, 7, 0.2)' : 'rgba(34, 197, 94, 0.2)'};
  color: ${props => props.type === 'auction' ? '#ffc107' : '#22c55e'};
  border: 1px solid ${props => props.type === 'auction' ? 'rgba(255, 193, 7, 0.3)' : 'rgba(34, 197, 94, 0.3)'};
  display: flex;
  align-items: center;
  gap: 4px;
`;

const SellerInfo = styled.div`
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.6);
  margin-bottom: 16px;
`;

const ActionButton = styled.button`
  width: 100%;
  padding: 12px 0;
  border: none;
  border-radius: 12px;
  background: linear-gradient(135deg, #22c55e 0%, #065f46 100%);
  color: white;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(34, 197, 94, 0.4);
  }
  
  &:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    transform: none;
  }
`;

const EmptyState = styled.div`
  grid-column: 1 / -1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
  text-align: center;
  color: rgba(255, 255, 255, 0.5);
`;

const LoadingState = styled.div`
  grid-column: 1 / -1;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 60px 20px;
  color: rgba(255, 255, 255, 0.7);
`;

interface MarketplaceListingsProps {
  onBuyDomain?: (listing: MarketplaceListing) => void;
  onMakeOffer?: (listing: MarketplaceListing) => void;
}

export function MarketplaceListings({ onBuyDomain, onMakeOffer }: MarketplaceListingsProps) {
  const [listings, setListings] = useState<MarketplaceListing[]>([]);
  const [loading, setLoading] = useState(true);
  const { address } = useAccount();

  useEffect(() => {
    loadListings();
  }, []);

  const loadListings = async () => {
    try {
      setLoading(true);
      const data = await marketplaceService.getActiveListings();
      setListings(data);
    } catch (error) {
      console.error('Failed to load marketplace listings:', error);
    } finally {
      setLoading(false);
    }
  };

  const formatAddress = (address: string) => {
    return `${address.slice(0, 6)}...${address.slice(-4)}`;
  };

  const formatPrice = (price: string, currency: string = 'CTC') => {
    return `${price} ${currency}`;
  };

  if (loading) {
    return (
      <ListingsContainer>
        <LoadingState>
          <div>Loading marketplace listings...</div>
        </LoadingState>
      </ListingsContainer>
    );
  }

  if (listings.length === 0) {
    return (
      <ListingsContainer>
        <EmptyState>
          <FaTag size={48} style={{ marginBottom: '16px', opacity: 0.5 }} />
          <h3 style={{ marginBottom: '8px', fontSize: '1.2rem' }}>No Listings Available</h3>
          <p>There are currently no domains listed for sale.</p>
        </EmptyState>
      </ListingsContainer>
    );
  }

  return (
    <ListingsContainer>
      {listings.map((listing) => (
        <ListingCard key={listing.id}>
          <DomainName>
            <FaEthereum size={20} />
            {listing.domain?.name || 'Unknown Domain'}
          </DomainName>
          
          <ListingInfo>
            <Price>
              <FaEthereum size={16} />
              {formatPrice(listing.price, listing.currency)}
            </Price>
            <ListingType type={listing.listing_type}>
              {listing.listing_type === 'auction' ? <FaGavel size={12} /> : <FaTag size={12} />}
              {listing.listing_type === 'auction' ? 'Auction' : 'Fixed Price'}
            </ListingType>
          </ListingInfo>

          <SellerInfo>
            Seller: {formatAddress(listing.seller_address)}
          </SellerInfo>

          {listing.listing_type === 'auction' && listing.auction_end_time && (
            <div style={{ 
              fontSize: '0.9rem', 
              color: 'rgba(255, 255, 255, 0.6)', 
              marginBottom: '16px',
              display: 'flex',
              alignItems: 'center',
              gap: '6px'
            }}>
              <FaClock size={12} />
              Ends: {new Date(listing.auction_end_time).toLocaleDateString()}
            </div>
          )}

          <div style={{ display: 'flex', gap: '8px' }}>
            {listing.listing_type === 'fixed_price' && (
              <ActionButton
                onClick={() => onBuyDomain?.(listing)}
                disabled={!address || listing.seller_address.toLowerCase() === address?.toLowerCase()}
              >
                {!address ? 'Connect Wallet' : 
                 listing.seller_address.toLowerCase() === address?.toLowerCase() ? 'Your Listing' : 
                 'Buy Now'}
              </ActionButton>
            )}
            
            {listing.listing_type === 'auction' && (
              <ActionButton
                onClick={() => onMakeOffer?.(listing)}
                disabled={!address || listing.seller_address.toLowerCase() === address?.toLowerCase()}
              >
                {!address ? 'Connect Wallet' : 
                 listing.seller_address.toLowerCase() === address?.toLowerCase() ? 'Your Auction' : 
                 'Place Bid'}
              </ActionButton>
            )}
          </div>
        </ListingCard>
      ))}
    </ListingsContainer>
  );
}