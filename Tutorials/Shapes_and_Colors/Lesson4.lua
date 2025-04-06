----------------------------------------------------------------
-- Shapes and Colors :: 
-- Part 4: Buttons - Assigning and resetting colors
-- Goal: Introduce the basic structure of a Codea program and 
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
    
    -- Button to assign color
    parameter.action("Assign Color", assignColor)
    
    -- Button to reset colors
    parameter.action("Reset Colors", function() shapeColors = {} end)
    
    shapes = {}
    local cube = scene:entity()
    cube:add(craft.renderer, craft.model.cube(vec3(1, 1, 1)))
    cube:get(craft.renderer).material = craft.material(asset.builtin.Materials.Standard)
    cube.position = vec3(0, 0, 0)
    table.insert(shapes, cube)
    
    local sphere = scene:entity()
    sphere:add(craft.renderer, craft.model.icosphere(0.5, 2))
    sphere:get(craft.renderer).material = craft.material(asset.builtin.Materials.Standard)
    sphere.position = vec3(0, 0, 0)
    table.insert(shapes, sphere)
    
    shapeColors = {}
end

-- Function to assign the selected color to the active shape
function assignColor()
    if Shape >= 1 and Shape <= 2 then
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
        if i == Shape then
            shape.active = true
            local currentColor = shapeColors[i] or SelectedColor
            shape:get(craft.renderer).material.diffuse = currentColor
        else
            shape.active = false
        end
    end
end
