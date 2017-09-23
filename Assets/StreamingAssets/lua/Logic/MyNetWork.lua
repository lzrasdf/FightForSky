
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
    log("MyNetwork" .. data or "nil")
    cur_ProtocalData = data
    if not data then
    	return
    end
    self.FireProtocol(data)
end

--首层确定协议号
function MyNetwork.FireProtocol( message )
	local protocalId = string.sub(message,1,16)
	local str_len = string.len(message)

	cur_ProtocalData = string.sub(message,17,str_len)
	protocalId = tonumber(protocalId, 2)
	print('收到协议',protocalId)
	EventManager:Fire(tostring(protocalId))
end

--按位读取协议数据
function MyNetwork.GetMsgData(typeId)
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
		local bit_len = string.sub(cur_ProtocalData,1,ProtocalDataId[typeId])
		len = tonumber(bit_len, 2)--字符串长度

		data = string.sub(cur_ProtocalData, ProtocalDataId[typeId]+1,  ProtocalDataId[typeId]+len)
		cur_ProtocalData = string.sub(cur_ProtocalData, ProtocalDataId[typeId]+len+1, str_len)
	else
		data = string.sub(cur_ProtocalData, 1,  ProtocalDataId[typeId])
		cur_ProtocalData = string.sub(cur_ProtocalData, ProtocalDataId[typeId]+1, str_len)
		data = tonumber(data, 2)
	end
	if not cur_ProtocalData or string.len(cur_ProtocalData)<=0 then
		cur_ProtocalData = nil
	end
	return data
end

--请求协议数据
function MyNetwork.SendMsgData(protocol_id , str_id , ... )
	if not protocol_id then
		return
	end

	str_id = str_id or ''
	local msg = ConvertStrAddBit(ConvertDec2X(protocol_id, 2),16)

	local parm    = {...}
	local len     = getTableLength(parm)
	local str_len = string.len(str_id)

	if str_len ~= len then
		error("协议发送数据数量有误")
		return
	end
	for i=1,str_len do
		local cur_id  = string.sub(str_id,i,i)
		local bit_num = ProtocalDataId[cur_id]

		if cur_id ~= "s" then
			local temp = ConvertDec2X(parm[i], 2)
			msg = msg .. ConvertStrAddBit(temp,bit_num)
		else
			local _str_len = string.len(parm[i])
			local temp = ConvertDec2X(_str_len, 2)
			temp = ConvertStrAddBit(temp,bit_num)
			msg = msg .. temp .. parm[i]
		end
	end
	LuaFramework.MyNetworkManager.SendMsg(msg)
end