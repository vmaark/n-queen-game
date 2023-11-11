'use client'

import {
  Share,
  Globe,
  ArrowRight
} from "lucide-react"
import { Button, buttonVariants } from '@/components/ui/button'

export default function Home() {
  return (
    <main className="
      px-6 py-14
      sm:px-10
    ">
      <div>
        {/* <a target="_blank" rel="no-opener" href="https://lens.xyz"> */}
          <div className="
          flex
          text-foreground mb-2">
            <div className="
            cursor-pointer items-center 
            flex grow-0 bg-secondary py-1 px-3 rounded-lg ">
              <p className='mr-2'>📚</p>
              <p className="text-sm">
              Learn more about Lens Protocol.
              </p>
              <ArrowRight className='ml-2' size={14} />
            </div>
          </div>
        {/* </a> */}
        <h1 className="text-5xl font-bold mt-3">
          Lens PWA 
        </h1>
        <p className="mt-4 max-w-[750px] text-lg text-muted-foreground sm:text-xl">
          An application boilerplate built with a modern stack. Simple to get started building your first social app. Leveraging ShadCN, Lens Protocol, Next.js, and WalletConnect.
        </p>
        <div className="mt-6 flex">
          <Button variant="outline" className='mr-3'>
            <Share className="h-4 w-4 mr-1" />
            Share
          </Button>
          <a
            target="_blank"
            rel="no-opener" href="https://aave.notion.site/08521d6d8ec84d10bf0f6d03abcf60cc?v=eb989b589d7447918187bf3c588a2748&pvs=4"
            className={buttonVariants({ variant: "default" })}>
            <Globe className="h-4 w-4 mr-1 text-white" />
            <p className="text-white">Explore Lens Apps</p>
          </a>
        </div>
      </div>
    </main>
  )
}