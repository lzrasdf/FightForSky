require "Common/define"

require "3rd/pblua/login_pb"
require "3rd/pbc/protobuf"

local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local print_r = require "3rd/sproto/print_r"

KeyInputCtrl = KeyInputCtrl or {};
local self = KeyInputCtrl;

local transform;
local gameObject;

--构建函数--
function KeyInputCtrl.New()
    logWarn("KeyInputCtrl.New--->>")
	return self;
end

--启动事件--
function KeyInputCtrl.OnCreate(obj)
	logWarn("KeyInputCtrl lua--->>")
	gameObject = obj;
	transform = obj.transform;
end

--关闭事件--
function KeyInputCtrl.Close()
end