-- Assignment:              Fix the missing code blocks

-- Restrictions:            You are not allowed to add any additional variables
--                          or functions unless otherwise told to do so

-- Grading Scheme:          Functional code: 60%
--                          Formatted  code: 20%
--                          Explanations   : 20%

-- Grade required to pass:  95%


----- START -----

-- Variables
rnet = {}

local rnetSide        = ""
local rnetFreq        = nil
local rnetChan        = ""
local rnetON          = "REDNET_ON"
local rnetOFF         = "REDNET_OFF"
local compID          = os.getComputerID()
local domainServer    = nil -- Will be acquired either by given value or broadcasting and listening for a value return
local sneakyFindArray = {}

-- Turn on rednet broadcasting the way we want to (required to be valid against configured domain server)
function rnet.InitializeInternet()
    rednet.open(rnetSide)
    rednet.broadcast(tostring(compID), rnetON)
end

-- Sends message to specified computer ID
function rnet.SendToID(id, msg, proto)
    rednet.send(id, msg, proto)
end

-- Finds all computers hosting the following protocol
function rnet.SneakyFind(proto)
    sneakyFindArray = { rednet.lookup(proto) }
end

-- Broadcast some data on a given protocol globally
function rnet.SendAll(msg, proto)
    rednet.broadcast(msg, proto)
end

-- Spends 5 seconds attempting to listen and find a domain server ID to connect with and store
function rnet.FindDomainServer()
    rednet.broadcast("", "DOMAIN_SERVER_SEARCH")
    local id,msg = rednet.receive("DOMAIN_SERVER_IDENTIFY", 5)

    if msg == "DOMAIN_SERVER_EAST_COAST" then
        domainServer = id
        return true
    end
    return false
end

-- rednet function that will actively listen for the right domain server response
-- so that we may return that value in response to it receiving our packet of
-- information. 
function rnet.ListenForDomainServerResponse(proto)
    -- Reason to loop this: Possible to receive messages on same protocol from other machines that aren't the domainServer
    -- (bad actors possibility or just spam)
    for i=1,10 do
        local id,msg = rednet.receive(proto, 30)

        if id == domainServer then
            return msg
        end
    end
    return false -- Implies POSSIBLE chance domain server went offline / could not receive our packet of information
end

-- rednet function that connects to a globally placed DOMAIN server in-game
-- this server is a well-known publicly accessed computer that can transfer
-- your information onto other computers that are subscribed to messages
-- (protocols) on this chain of networking
function rnet.sendToDomainServer(data, proto)
    if FindDomainServer() then
        rednet.send(domainServer, data, proto)
        if ListenForDomainServerResponse() then
            return msg -- Sucessful connection + response from domain server
        end
    end
    return false -- Implies failed connection or failed response from domain server
end

return rnet