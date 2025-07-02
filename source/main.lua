-- Handy constants --

local pd <const> = playdate
local gfx <const> = pd.graphics
local screenWidth <const>, screenHeight <const> = pd.display.getSize()



-- Life variables --

local cellSize = 1
local nRows = screenHeight / cellSize
local nCols = screenWidth / cellSize
local grid
local nextGrid
local image = gfx.image.new(screenWidth, screenHeight)



-- Life functions --

local function lifeInit()
    grid = table.create(nRows * nCols, 0)
    nextGrid = table.create(nRows * nCols, 0)
    for i = 1, nRows do
        for j = 1, nCols do
            local cell_index = (i - 1) * nCols + j
            grid[cell_index] = math.random(0, 1)
            nextGrid[cell_index] = grid[cell_index]
        end
    end
end

local function lifeUpdate()
    grid, nextGrid = nextGrid, grid
end

local function lifeDraw()
    gfx.lockFocus(image)
        for i = 1, nRows do
            for j = 1, nCols do
                local cell_index = (i - 1) * nCols + j
                if grid[cell_index] == 1 then
                    gfx.fillRect(j - 1, i - 1, cellSize, cellSize)
                end
            end
        end
    gfx.unlockFocus()
    image:draw(0, 0)
end



-- Game setup
lifeInit()
lifeDraw()

-- Game loop
function playdate.update()
    lifeUpdate()
    gfx.clear()
    lifeDraw()
    pd.drawFPS(0, 0)
end
