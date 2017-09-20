require "Common/define"

require "3rd/pblua/login_pb"
require "3rd/pbc/protobuf"

local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local print_r = require "3rd/sproto/print_r"

LZRSecondCtrl = LZRSecondCtrl or {};
local self = LZRSecondCtrl;

local panel;
local prompt;
local transform;
local gameObject;

--构建函数--
function LZRSecondCtrl.New()
    logWarn("LZRSecondCtrl.New--->>")
    self.testData = "LZRSecondCtrl_data"
	return self;
end

function LZRSecondCtrl.Awake()
    logWarn("LZRSecondCtrl lua--->>")
end

--启动事件--
function LZRSecondCtrl.OnCreate(obj)
	logWarn("LZRSecondCtrl lua--->>")
	gameObject = obj;
	transform = obj.transform;

	-- panel = transform:GetComponent('UIPanel');
	-- lzrfirst = transform:GetComponent('LuaBehaviour');
end

--初始化面板--
function LZRSecondCtrl.InitPanel(objs)
    
end

--单击事件--
function LZRSecondCtrl.OnClick(go)
	logWarn("OnClick---->>>"..go.name);
	--print('----LZR LZRSecondCtrl.lua 47-- LZRFirstModel.Des=',LZRFirstModel:GetInstance().describe)
end

--关闭事件--
function LZRSecondCtrl.Close()
	-- panelMgr:ClosePanel(CtrlNames.LZRFirst);
end