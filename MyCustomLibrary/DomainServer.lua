-- LUA File that handles all domain server calls. This code is generally not publicized however
-- a call can be made to the developer to understand better how this function

-- this intentional disconnect in code transparancy is to help teach using code without libraries/API's
-- it's evil :)

-- includes first
local debug = require("CustomDebug")
local term = require("TerminalMath")

ret = {}

local domainID = os.getComputerID() -- Important domain ID
local domainProto = "DOMAIN_SERVER_EAST_COAST" -- protocol for this domain server recognizer
local domainIdentifier = -1
local modem = peripheral.find("modem") or error("No modem attached", 0)
local prefix = "[DNS-EC-]" .. domainID .. "]: "
local GlobalProtocols = {"NONE"}

function ret.safeShutdown()
    coroutine.yield() -- yield any active coroutines
    print(prefix .. "SAFE SHUTDOWN REQUESTED. STARTING SHUTDOWN")

    -- Send out our final goodbye message
    modem.transmit(domainIdentifier, nil, (prefix .. " SHUTTING DOWN. DOMAIN NETWORK FOR THIS PORT HAS BEEN CLOSED"))
    -- in the future it would also be ideal to send out a secondary message with an attached follow-up port for another
    -- domain server that is still active to users have a safe outlet to connect to for information :)

    -- Now clean up everything
    modem.closeAll()
    debug.debug("DomainServer.lua:safeShutdown", "DOMAIN_SAFE_SHUTDOWN", nil, nil)
    term.redirect(term.native()) -- Ensure we are only printing directly to terminal!
    term.ResetTerminal()
    sleep(0.5)

    print(prefix .. "SAFE SHUTDOWN REQUESTED. SHUTDOWN COMPLETE. GOODBYE")
    os.shutdown()
end

function ret.registerDomainServer()
    -- Will establish a unique connection as a domain server by broadcasting our protocol and ID and key
    -- The domain server will *not* use the same rnet_system file for reasons. This will be changed
    -- in the near future though (I say this but will probably forget lol)
    for i=0,65535 do
        if (modem.isOpen(i)) then
            modem.open(i) -- Open a modem on the nearest available channel to 1
            domainIdentifier = i
            local buffer = domainProto .. "_" .. tostring(i) -- Tags channel to our protocol
            return
        end
    end

    -- infers we unsuccessfully found a channel
    debug.debug("DomainServer.lua:registerDomainServer", "NO SERVER FOUND", nil, nil)
    safeShutdown()
end

-- functional replier if certain optional arguments are not meant
-- the domain server will persecute >:)
function ret.usage()
    local buffer = prefix .. "Usage string requested. Hello there, our protocol is " .. domainProto .. " on modem port " .. domainIdentifier .. ". You may transmit and receive on this channel."
    local buffer2 = "\n\nSENDING MESSAGES: modem.send(" .. domainIdentifier .. ", your_modem_port_here, {[CompID]: nickname, {Information}}"
    local buffer3 = "\n\nRECEIVING MSGS  : Ensure your proper modem subscription in the original modem.send. We will broadcast out our protocol to you 3 times for confirmation we have received. You do not need to reply to us"
    local buffer4 = "\n\nNOTICE: Domain server system is strict! Your {Information} table must be formatted as so: {\"SENDING\": 0/1, \"REQUESTING\": 0/1, \"CONTENTS\": options}"
    local buffer5 = "\n\n optionalContentsTableHere: {\"SUBSCRIPTION_PROTOCOL\": PROTO_HERE, \"PUBLISHING_PROTOCOL\": PROTO_HERE, \"PUBLISH_CONTENT_HERE\": data_here}"
    local buffer6 = "\n\n * If you are confused. You may access a list of public protocols via the following message:"
    local buffer7 = "     modem.transmit(" .. domainIdentifier .. ", your_modem_port_here, \"PAYLOAD\": {\"AVAILABLE_PROTOCOLS\": 1})"

    local send = buffer .. buffer2 .. buffer3 .. buffer4
    return send
end

-- Global message sender :)
-- Will send messages single-thread
function ret.sendMessage(contents, subscriberChannel)
    modem.transmit(subscriberChannel, domainIdentifier, contents)
end

-- Global listener for ALL messages :)
function ret.receiveMessage()
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")

    if message ~= type("table") then
        return -- Malformed object
    end

    local subscriber = message["id"] or nil
    local payload = message["PAYLOAD"] or nil
    local subscriberChannel = channel

    -- If the subscriber either didn't properly fill out their ID/payload >:(
    if subscriber == nil or subscriber ~= type("number") or payload == nil then
        sendMessage(usage())
    end

    -- First verify if they are basically asking us for help on how to request or send things formally through us
    if payload["AVAILABLE_PROTOCOLS"] ~= nil then
        -- A request has been formally requested for all available known protocols
        sendMessage(GlobalProtocols, subscriberChannel)
        return
    end

    -- Now we have to decide what to do with the payload! If they're trying to send it to another
    -- network on the computer, we need to dissect this from the properly formatted subtable in their
    -- payload. The payload SHOULD follow the following form:
    -- {"SENDING": 0/1, "REQUESTING": 0/1, "CONTENTS": optionalContentsHere}

    if payload["REQUESTING"] then
        -- Logic: Formal request from protocol for content. Will broadcast on this identifiers behalf 
        -- for a content subscription

        local optionsCopy = payload["CONTENTS"]
        local proto = optionsCopy["SUBSCRIPTION_PROTOCOL"]

        requestSubscription(proto, subscriber)
        return
    end

    if payload["SENDING"] then
        -- Logic: Sending content through a subscription to all users that are attached to that subscription

        local optionsCopy = payload["CONTENTS"]
        local proto = optionsCopy["PUBLISHING_PROTOCOL"]

        requestPublish(proto, optionsCopy["PUBLISH_CONTENT_HERE"])
        return
    end

    -- We can only get this far down if user improperly requested neither subscription or publish
    -- which infers incorrect use of our service. Send them our instructions
    sendMessage(usage())
end

-- Adds user to subscription list for a certain protocol
-- proto: number-type
-- subsc: number-type (modem-port expected)
function ret.requestSubscription(proto, subscriber)
    -- Take this new subscriber and attach their information to the list that is under this protocol.
    File.CreateNestedDirectories("/DNS", proto)
    File.AppendToFile(proto, subscriber)
end

function ret.requestPublish(proto, contents)
    -- Attempt to find existing proto user list (if none just return) and publish to all those modem ports the
    -- content of the message
    userList = File.ReadSimpleFile("/DNS/" .. proto)

    if userList ~= nil then
        -- Main logic here
        -- Assumed structure of userList: Simple array of values (modem values in our case)
        for i=1,#userList do
            local subscriber = userList[i]
            sendMessage(contents, subscriber)
        end
    end
end