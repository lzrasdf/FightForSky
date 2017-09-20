KeyInputCtrl = KeyInputCtrl or {};
local self = KeyInputCtrl;

local transform;
local gameObject;

local function Update()
    if UnityEngine.Input.GetKeyDown("a") then
    	local lzr_ctrl = CtrlManager.GetCtrl(CtrlNames.LZRFirst)
   		print('----LZR LZRFirstCtrl.lua 22-- data=',lzr_ctrl.testData)
    end

    if UnityEngine.Input.GetKeyDown("s") then
    	local temp = LZRFirstModel:GetInstance( ).describe
    	print('----LZR KeyInputCtrl.lua 30-- temp=',temp)
    end
end

--构建函数
function KeyInputCtrl.New()
    logWarn("KeyInputCtrl.New--->>")
    UpdateBeat:Add(Update, self)
	return self;
end

--关闭事件--
function KeyInputCtrl.Close()
	
end