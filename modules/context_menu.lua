
-- context_menu.lua
local context_menu = {}
context_menu.__index = context_menu

function context_menu.new(x, y, w, items)
    local self = setmetatable({}, context_menu)

    self.x, self.y = x, y
    self.w = w or 150
    self.items = items or {}

    self.itemHeight = 25
    self.visible = false
    self.active = true
    self.hover = false
    self.zindex = #LuvKit._registry
    self.inputActive = false
    self.inputText = ""
    self.onInputConfirm = nil

    return self
end

function context_menu:show(x, y, items)
    self.x = x
    self.y = y
    self.items = items or self.items
    self.visible = true
    self.inputActive = false
    self.inputText = ""
end

function context_menu:hide()
    self.visible = false
    self.inputActive = false
end

function context_menu:update(dt)
    if not self.visible then return end

    local mx, my = love.mouse.getX(), love.mouse.getY()
    self.hover = mx >= self.x and mx <= self.x + self.w and my >= self.y and my <= self.y + #self.items * self.itemHeight

    return self.hover
end

function context_menu:draw()
    if not self.visible then return end

    love.graphics.setColor(0.95, 0.95, 0.95)
    love.graphics.rectangle("fill", self.x, self.y, self.w, #self.items * self.itemHeight, 4, 4)

    for i, item in ipairs(self.items) do
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(item.label, self.x + 5, self.y + (i - 1) * self.itemHeight + 5)
    end

    if self.inputActive then
        local iy = self.y + #self.items * self.itemHeight + 10
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", self.x, iy, self.w, 25, 4, 4)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(self.inputText, self.x + 5, iy + 5)
    end
end

function context_menu:mousepressed(x, y, button)
    if not self.visible or not self.active then return end

    if button == 1 and not self.inputActive then
        for i, item in ipairs(self.items) do
            local iy = self.y + (i - 1) * self.itemHeight
            if x > self.x and x < self.x + self.w and y > iy and y < iy + self.itemHeight then
                if item.type == "action" then
                    item.callback()
                    self:hide()
                elseif item.type == "input" then
                    self.inputActive = true
                    self.inputText = ""
                    self.onInputConfirm = item.callback
                end
                break
            end
        end
    end
end

function context_menu:textinput(t)
    if self.inputActive then
        self.inputText = self.inputText .. t
    end
end

function context_menu:keypressed(key)
    if self.inputActive then
        if key == "return" and self.onInputConfirm then
            self.onInputConfirm(self.inputText)
            self:hide()
        elseif key == "backspace" then
            self.inputText = self.inputText:sub(1, -2)
        elseif key == "escape" then
            self.inputActive = false
        end
    end
end

-- Enregistrement dans LuvKit
LuvKit._types = LuvKit._types or {}
LuvKit._types["context_menu"] = context_menu

return context_menu
