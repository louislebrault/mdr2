module Lib
    ( listenMDR
    ) where

import Network.Socket
import Network.Socket.ByteString.Lazy (send)
import Data.ByteString.Lazy.UTF8 (fromString)

address = tupleToHostAddress (127, 0, 0 ,1)

listenMDR :: IO ()
listenMDR = do
    sock <- socket AF_INET Stream 0    -- create socket
    setSocketOption sock ReuseAddr 1   -- make socket immediately reusable - eases debugging.
    bind sock (SockAddrInet 4242 address)   -- listen on TCP port 4242.
    listen sock 2                              -- set a max of 2 queued connections
    mainLoop sock

mainLoop :: Socket -> IO ()
mainLoop sock = do
    conn <- accept sock     -- accept a connection and handle it
    runConn conn            -- run our server's logic
    mainLoop sock           -- repeat

runConn :: (Socket, SockAddr) -> IO ()
runConn (sock, _) = do
    send sock (fromString "Hello!\n")
    close sock
