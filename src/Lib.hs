module Lib
    ( listenMDR
    ) where

import Network.Socket

address = tupleToHostAddress (127, 0, 0 ,1)

listenMDR :: IO ()
listenMDR = do
    sock <- socket AF_INET Stream 0    -- create socket
    setSocketOption sock ReuseAddr 1   -- make socket immediately reusable - eases debugging.
    bind sock (SockAddrInet 4242 address)   -- listen on TCP port 4242.
    listen sock 2                              -- set a max of 2 queued connections

