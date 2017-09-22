
require "Common/define"
require "Common/protocal"
require "Common/functions"
Event = require 'events'

require "3rd/pblua/login_pb"
require "3rd/pbc/protobuf"

local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local print_r = require "3rd/sproto/print_r"

--接收数据的主要流程就是信息到达后分两多步裁剪下发

MyNetwork = {};
local self = MyNetwork

local cur_ProtocalData = nil

function MyNetwork.Start()

end

--Socket消息--
function MyNetwork.Receive(data)
    log("MyNetwork" .. data)
    if not data then
    	return
    end
    self.FireProtocol(data)
end

--首层确定协议号
function MyNetwork.FireProtocol( message )
	local protocalId = string.sub(str,1,16)
	local str_len = string.len(message)

	cur_ProtocalData = string.sub(str,17,str_len)
	EventManager:Fire(protocalId)
end

--按位读取协议数据
function MyNetwork.SendMsg(typeId)
	local data = nil

	if not cur_ProtocalData then
		print('!!!没有协议缓存内容!!!')
		return
	end

	if not typeId then
		print('!!!协议传入参数错误!!!')
		return
	end
	--判断长度是否合适，如果是字符串的话需要去除16位数值码并取出字符串

	local str_len = string.len(cur_ProtocalData)
	local len = ProtocalDataId[typeId]
	if typeId == "s" then
		len = 1
		cur_ProtocalData = string.sub(cur_ProtocalData,17,str_len)
	end

	if str_len < len then
		print('!!!协议长度错误!!!')
		return
	end

	data = string.sub(cur_ProtocalData,1,len)

	cur_ProtocalData = string.sub(cur_ProtocalData,17,str_len)

	if str_len == len then
		cur_ProtocalData = nil
	end

	data = bit.tonumber (data, len)

	return data
end