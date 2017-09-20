local transform;
local gameObject;

LZRFirstPanel = {};
local this = LZRFirstPanel;

--启动事件--
function LZRFirstPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function LZRFirstPanel.InitPanel()
	logWarn("InitPanel lua--->>"..gameObject.name);
end

--单击事件--
function LZRFirstPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end