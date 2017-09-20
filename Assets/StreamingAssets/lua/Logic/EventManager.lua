--利用ID分离对EventManager的直接引用
EventManager = EventManager or BaseClass()

EventManager.list_all = EventManager.list_all or {}
EventManager.bind_id = 0
--事件系统

local self = EventManager

function EventManager.Init()
	return self
end

function EventManager:Bind(event_id, event_func)
	if event_id == nil then
		error("Try to bind to a nil event_id")
		return
	end
	
	if event_func == nil then
		error("Try to bind to a nil event_func")
		return
	end

	self.list_all[event_id] = self.list_all[event_id] and self.list_all[event_id] or {}

	self.bind_id = self.bind_id + 1

	self.list_all[event_id][self.bind_id] = {	
		key = self.bind_id,
		event_id = event_id,
		call_back = event_func
	}

	return self.bind_id
end

function EventManager:UnBind(event_id,bind_id)
	if bind_id == nil then
		return
	end
	if self.list_all[event_id] == nil then
		return
	end
	self.list_all[event_id][bind_id] = nil
end

function EventManager:UnBindAll(event_id)
	self.list_all[event_id] = {}
end

--立即触发
function EventManager:Fire(event_id, ...)
	if event_id == nil then
		error("Try to call EventManager:Fire() with a nil event_id")
		return
	end

	if self.list_all[event_id] == nil then
		return
	end

	for k,v in pairs(self.list_all[event_id]) do
		v.call_back(...)
	end
end
