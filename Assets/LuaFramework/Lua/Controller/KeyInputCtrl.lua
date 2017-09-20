KeyInputCtrl = KeyInputCtrl or {};
local self = KeyInputCtrl;

local transform;
local gameObject;

local test_bind_id = nil

local function Update()
    if UnityEngine.Input.GetKeyDown("b") then
        if not test_bind_id then
            local function test()
            	local lzr_ctrl = CtrlManager.GetCtrl(CtrlNames.LZRFirst)
           		print('----LZR LZRFirstCtrl.lua 22-- data=',lzr_ctrl.testData)
            end
            test_bind_id = EventManager:Bind("test",test)
        end
        print('bind')
    end

    if UnityEngine.Input.GetKeyDown("u") then
        print('unbind=')
        EventManager:UnBind("test",test_bind_id)
        test_bind_id = nil
    end

    if UnityEngine.Input.GetKeyDown("f") then
        print("fire")
        EventManager:Fire("test")
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