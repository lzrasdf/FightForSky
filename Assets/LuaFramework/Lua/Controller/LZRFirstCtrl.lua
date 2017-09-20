require "Common/define"

require "3rd/pblua/login_pb"
require "3rd/pbc/protobuf"
require "Model/LZRFirstModel"

local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local print_r = require "3rd/sproto/print_r"

LZRFirstCtrl = LZRFirstCtrl or {};
local self = LZRFirstCtrl;
self.model = LZRFirstModel:GetInstance()

local panel;
local prompt;
local transform;
local gameObject;

--构建函数--
function LZRFirstCtrl.New()
    logWarn("LZRFirstCtrl.New--->>")
    self.testData = "LZRFirstCtrl_data"
	return self;
end

function LZRFirstCtrl.Awake()
    logWarn("LZRFirstCtrl lua--->>")
	panelMgr:CreatePanel('LZRFirst', self.OnCreate);
end

--启动事件--
function LZRFirstCtrl.OnCreate(obj)
	logWarn("LZRFirstCtrl lua--->>")
	gameObject = obj;
	transform = obj.transform;

	panel = transform:GetComponent('UIPanel');
	lzrfirst = transform:GetComponent('LuaBehaviour');
end

--初始化面板--
function LZRFirstCtrl.InitPanel(objs)
    
end

--单击事件--
function LZRFirstCtrl.OnClick(go)
	logWarn("OnClick---->>>"..go.name);
end

--关闭事件--
function LZRFirstCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.LZRFirst);
end
