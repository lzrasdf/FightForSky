LZRFirstModel = LZRFirstModel or {}

local self = LZRFirstModel

--构建函数--
function LZRFirstModel.New()
    LZRFirstModel.Instance = self
    self:Reset()
end

function LZRFirstModel.Reset()
    self.describe = "LZRFirstModel"
end

function LZRFirstModel:GetInstance( )
    if LZRFirstModel.Instance == nil then
        LZRFirstModel.New();
    end
    return LZRFirstModel.Instance
end