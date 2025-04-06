----------------------------------------------------------------
-- Shapes and Colors :: 
-- Part 5: Refactor - Data oriented design
-- Goal: Refactor the code to reduce repetition using a data-oriented approach
----------------------------------------------------------------

-- Called once at the start to initialize the program
function setup()
    scene = craft.scene()
    scene.camera.position = vec3(0, 0, -5)
    
    local light = scene:entity()
    light:add(craft.light, DIRECTIONAL)
    light.rotation = quat.eulerAngles(45, 45, 0)
    
    defaultColor = color(255, 255, 255, 255)
    parameter.integer("Shape", 1, 2, 1)
    parameter.color("SelectedColor", defaultColor)
    parameter.integer("CameraDistance", 1, 3, 1)
    parameter.action("Assign Color", assignColor)
    parameter.action("Reset Colors", function() shapeColors = {} end)
    
    -- Define shape data
    shapeData = {
        { model = craft.model.cube(vec3(1, 1, 1)), name = "Cube" },
        { model = craft.model.icosphere(0.5, 2), name = "Sphere" }
    }
    
    -- Create shapes from data
    shapes = {}
    for i, data in ipairs(shapeData) do
        local entity = scene:entity()
        entity:add(craft.renderer, data.model)
        entity:get(craft.renderer).material = craft.material(asset.builtin.Materials.Standard)
        entity.position = vec3(0, 0, 0)
        table.insert(shapes, entity)
    end
    
    shapeColors = {}
end

-- Function to assign the selected color to the active shape
function assignColor()
    if Shape >= 1 and Shape <= #shapes then
        shapeColors[Shape] = SelectedColor
        shapes[Shape]:get(craft.renderer).material.diffuse = SelectedColor
    end
end

-- Called every frame to update and render the scene
function draw()
    scene:update(DeltaTime)
    background(0, 0, 0, 255)
    scene.camera.position = vec3(0, 0, -5 * CameraDistance)
    scene:draw()
    
    for i, shape in ipairs(shapes) do
        shape.active = (i == Shape)
        if shape.active then
            local currentColor = shapeColors[i] or SelectedColor
            shape:get(craft.renderer).material.diffuse = currentColor
        end
    end
end
