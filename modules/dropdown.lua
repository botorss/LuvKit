
-- dropdown.lua
-- Version simple d'abord, puis version intégrée à LuvKit
local dropdown = {}
dropdown.__index = dropdown

-- Utilitaire easing
local function lerp(a, b, t)
    return a + (b - a) * t
end

--------------------------
-- VERSION SIMPLE
--------------------------
function dropdown.new(x, y, w, h, items, callback)
    local self = setmetatable({}, dropdown)
    self.x, self.y, self.w, self.h = x, y, w, h
    self.items = items or {}
    self.callback = callback or function(_) end
    self.open = false
    self.selected = nil
    self.hover = false
    self.itemHeight = h
    self.animationProgress = 0
    self.maxAnimation = #self.items * self.itemHeight
    return self
end

function dropdown:update(dt)
    local mx, my = love.mouse.getX(), love.mouse.getY()
    self.hover = mx >= self.x and mx <= self.x + self.w and my >= self.y and my <= self.y + self.h

    if self.open and self.animationProgress < self.maxAnimation then
        self.animationProgress = lerp(self.animationProgress, self.maxAnimation, 0.2)
    elseif not self.open and self.animationProgress > 0 then
        self.animationProgress = lerp(self.animationProgress, 0, 0.2)
    end
end

function dropdown:draw()
    -- Header
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 6, 6)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.selected or "Select...", self.x + 5, self.y + 5)

    -- Dropdown list (animated)
    if self.animationProgress > 1 then
        love.graphics.setScissor(self.x, self.y + self.h, self.w, self.animationProgress)
        for i, item in ipairs(self.items) do
            local iy = self.y + self.h + (i - 1) * self.itemHeight
            love.graphics.setColor(0.8, 0.8, 0.8)
            love.graphics.rectangle("fill", self.x, iy, self.w, self.itemHeight)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print(item, self.x + 5, iy + 5)
        end
        love.graphics.setScissor()
    end
end

function dropdown:mousepressed(x, y, button)
    if button ~= 1 then return end

    if x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h then
        self.open = not self.open
    elseif self.open then
        for i, item in ipairs(self.items) do
            local iy = self.y + self.h + (i - 1) * self.itemHeight
            if y >= iy and y <= iy + self.itemHeight and x >= self.x and x <= self.x + self.w then
                self.selected = item
                self.open = false
                self.callback(item)
                break
            end
        end
    end
end

function dropdown.mousereleased(x,y,button)
    -- body
end
--------------------------
-- VERSION LUVKIT
--------------------------
local LuvKit_dropdown = {}
LuvKit_dropdown.__index = LuvKit_dropdown

function LuvKit_dropdown.new(x, y, w, h, items)
    local self = setmetatable({}, LuvKit_dropdown)
    self.x, self.y, self.w, self.h = x, y, w, h
    self.items = items or {}
    self.open = false
    self.selected = nil
    self.hover = false
    self.itemHeight = h
    self.buttons = {}
    self.animationProgress = 0
    self.maxAnimation = #items * self.itemHeight

    self.visible = true
    self.active = true
    self.zindex = #LuvKit._registry

    for i, item in ipairs(items) do
        local b = LuvKit.create("button", x, y + h + (i - 1) * h, w, h, item)
        b:setCallback(function() self.selected = item; self.open = false end)
        self.buttons[#self.buttons + 1] = b
    end

    return self
end

function LuvKit_dropdown:update(dt)
    self.hover = LuvKit.collision(self.x, self.y, self.w, self.h, love.mouse.getX(), love.mouse.getY(), 1, 1)

    if self.open then
        self.animationProgress = lerp(self.animationProgress, self.maxAnimation, 0.2)
    else
        self.animationProgress = lerp(self.animationProgress, 0, 0.2)
    end

    for i, b in ipairs(self.buttons) do
        b.y = self.y + self.h + (i - 1) * self.itemHeight
        b.visible = self.open and ((i - 1) * self.itemHeight < self.animationProgress)
        b:update(dt)
    end
end

function LuvKit_dropdown:draw()
    if not self.visible then return end
    -- Head zone
    love.graphics.setColor(0.6, 0.6, 0.6)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 6, 6)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.selected or "Choisir...", self.x + 5, self.y + 5)

    -- Animated buttons
    for _, b in ipairs(self.buttons) do
        b:draw()
    end
end

function LuvKit_dropdown:mousepressed(x, y, button)
    if not self.visible or not self.active then return end
    if button == 1 and LuvKit.collision(self.x, self.y, self.w, self.h, x, y, 1, 1) then
        self.open = not self.open
    elseif self.open then
        for _, b in ipairs(self.buttons) do
            b:mousepressed(x, y, button)
        end
    else
        self.open = false
    end
end

-- Enregistrement dans LuvKit
LuvKit._types = LuvKit._types or {}
LuvKit._types["dropdown"] = LuvKit_dropdown

return {
    new = dropdown.new,
    LuvKitDropdown = LuvKit_dropdown
}
