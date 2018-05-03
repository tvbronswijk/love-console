local root=(...):match("(.-)[^%/%.]+$")
local colors=require(root .. 'colors')
local console={}
console.config={
    name=nil,                       -- Name of the console. unused.
    extend=false,                   -- Extend love.graphics with console.
    buffer_width=80,                -- Amount of columns.
    buffer_height=50,               -- Amount of rows.
    font=nil,                       -- Console font.
    font_size=16,                   -- Size of the font characters.
    background_color=colors.black,  -- Color of the background.
    foreground_color=colors.white   -- Color of the characters.
}
function console:initialize(props)
    if props ~= nil then
        for name, value in pairs(props) do
            self.config[name] = value
        end
    end 
    if self.config.font then
        love.graphics.setFont(love.graphics.newFont(self.config.font, self.config.font_size))
    end
    if self.config.extend then 
        love.graphics.console = self
    end
    love.window.setMode(self.config.buffer_width * self.config.font_size, 
                        self.config.buffer_height * self.config.font_size)
end
function console:print(line, col, row, text_color, background_color)
    love.graphics.setColor(background_color or self.config.background_color)
    love.graphics.rectangle("fill", 
        col * self.config.font_size, 
        row * self.config.font_size, 
        #line * self.config.font_size, 
        1 * self.config.font_size)
    love.graphics.setColor(self.config.foreground_color) 
    love.graphics.print({text_color or self.config.foreground_color, line}, 
    col * self.config.font_size, 
    row * self.config.font_size) 
end
function console:fill()
    for x = 0, self.config.buffer_width-1 do 
        for y = 0, self.config.buffer_height-1 do 
            self:print(string.char(love.math.random(65, 89)), x, y, colors.random(), colors.random())
        end
    end
end
return console
