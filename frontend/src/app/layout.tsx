import type { Metadata } from 'next'
import '@rainbow-me/rainbowkit/styles.css';
import { Providers } from './providers';
import './globals.css'

export const metadata: Metadata = {
  title: 'N Queen Tournament',
  description: 'N Queen Tournament ZK Challange',
}


function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}

export default RootLayout;