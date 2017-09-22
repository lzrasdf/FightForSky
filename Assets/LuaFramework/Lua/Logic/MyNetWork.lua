
require "Common/define"
require "Common/protocal"
require "Common/functions"
Event = require 'events'

require "3rd/pblua/login_pb"
require "3rd/pbc/protobuf"

local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local print_r = require "3rd/sproto/print_r"

MyNetwork = {};
local self = MyNetwork;

function MyNetwork.Start() 
    
end

--Socket消息--
function MyNetwork.Receive(data)
    log("MyNetwork" .. data)
end

