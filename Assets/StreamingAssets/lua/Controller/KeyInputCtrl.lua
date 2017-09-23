KeyInputCtrl = KeyInputCtrl or {};
local self = KeyInputCtrl;

local transform;
local gameObject;

local test_bind_id = nil
local test_bind_network = nil

local function Update()
    if UnityEngine.Input.GetKeyDown("a") then
        if not test_bind_id then
            local function test()
            	local lzr_ctrl = CtrlManager.GetCtrl(CtrlNames.LZRFirst)
           		print('----LZR LZRFirstCtrl.lua 22-- data=',lzr_ctrl.testData)
            end
            test_bind_id = EventManager:Bind("test",test)
        end
        print('bind')
    end

    if UnityEngine.Input.GetKeyDown("d") then
        print('unbind=')
        EventManager:UnBind("test",test_bind_id)
        test_bind_id = nil
    end

    if UnityEngine.Input.GetKeyDown("s") then
        print("fire")
        EventManager:Fire("test")
    end

    --网络测试调连部分
    if UnityEngine.Input.GetKeyDown("z") then
        if not test_bind_network then
            local function getData()
                local data = MyNetwork.GetMsgData("s")
                print('网络传输测试 data=',data)
            end
            test_bind_network = EventManager:Bind("14907",getData)
            print('绑定网络测试事件')
        else
            print('网络测试事件已存在')
        end
    end

    if UnityEngine.Input.GetKeyDown("x") then
        LuaFramework.MyNetwork.SendMsgData(14907 , "csc" , 8,"str",1)
    end

    if UnityEngine.Input.GetKeyDown("c") then
        print('解除网络测试事件绑定')
        EventManager:UnBind("14907",test_bind_network)
        test_bind_network = nil
    end
    --网络测试调连部分

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