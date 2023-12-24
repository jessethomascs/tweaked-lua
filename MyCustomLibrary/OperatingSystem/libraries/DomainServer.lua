-- The domain server is setup as a pub/sub sort of deal with "topics" that subscribers can subscribe to in order
-- to get information. DomainServer also handles request/reply information where a subscriber can "request" via a 
-- filtered topic

DomainServer = {}

local compID = os.getComputerID()
local modem = peripheral.find("modem") or error("No modem attached", 0)
local domainIdentifier = -1
local prefix = "[DNS-EC-" .. domainID .. "]: "

function DomainServer.Initialize()
    RegisterDomainServer()
end

function DomainServer.SafeShutdown()
    -- Send out our final goodbye message
    print(prefix .. "SAFE SHUTDOWN REQUESTED. STARTING SHUTDOWN")
    modem.transmit(domainIdentifier, nil, (prefix .. " SHUTTING DOWN. DOMAIN NETWORK FOR THIS PORT HAS BEEN CLOSED"))
    -- in the future it would also be ideal to send out a secondary message with an attached follow-up port for another
    -- domain server that is still active to users have a safe outlet to connect to for information :)

    -- Now clean up everything
    modem.closeAll()
    debug.debug("DomainServer.lua:SafeShutdown", "DOMAIN_SAFE_SHUTDOWN", nil, nil)
    term.redirect(term.native()) -- Ensure we are only printing directly to terminal!
    term.ResetTerminal()
    sleep(0.5)

    print(prefix .. "SAFE SHUTDOWN REQUESTED. SHUTDOWN COMPLETE. GOODBYE")
    os.shutdown()
end

function DomainServer.RegisterDomainServer()
    -- Will establish a unique connection as a domain server by broadcasting our protocol and ID and key
    -- The domain server will *not* use the same rnet_system file for reasons. This will be changed
    -- in the near future though (I say this but will probably forget lol)
    for i=0,65535 do
        if (modem.isOpen(i)) then
            modem.open(i) -- Open a modem on the nearest available channel to 1
            domainIdentifier = i -- log the dynamic port chosen
            return
        end
    end

    -- infers we unsuccessfully found a channel
    debug.debug("DomainServer.lua:registerDomainServer", "NO SERVER FOUND", nil, nil)
    SafeShutdown()
end

-- Publish(data, topic)
-- data:  Packet of data to be published
-- topic: Topic to publish on
function DomainServer.Publish(data, topic)
    topic = topic or "TOPIC_EVERYTHING" -- equiv of just a nil check

    -- Type of data ~ MUST ~ be of table type
    if type(data) ~= "table" then
        print("Malformed data has entered pipeline. FLUSHING")
        -- flushes toilet here lol
    else
        rednet.broadcast(data, topic)
        modem.transmit(domainIdentifier, domainIdentifier, data) -- Just raw dog it out there
    end
end