----------------------------------------------------------------
-- Shapes and Colors
-- Part 2: Intro to Parameters - Switching shapes and colors
-- Goal: Add parameters to switch between shapes and add color globally
----------------------------------------------------------------

-- Called once at the start to initialize the program
function setup()
    -- Create a new 3D scene
    scene = craft.scene()
    
    -- Position the camera
    scene.camera.position = vec3(0, 0, -5)
    
    -- Add a directional light
    local light = scene:entity()
    light:add(craft.light, DIRECTIONAL)
    light.rotation = quat.eulerAngles(45, 45, 0)
    
    -- Default color for shapes
    defaultColor = color(255, 255, 255, 255) -- White
    
    -- Parameter to switch between shapes (1 = cube, 2 = sphere)
    parameter.integer("Shape", 1, 2, 1)
    
    -- Parameter to select a color
    parameter.color("SelectedColor", defaultColor)
    
    -- Create shapes
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
end

-- Called every frame to update and render the scene
function draw()
    scene:update(DeltaTime)
    background(0, 0, 0, 255)
    scene:draw()
    
    -- Show only the active shape and set its color
    for i, shape in ipairs(shapes) do
        if i == Shape then
            shape.active = true
            shape:get(craft.renderer).material.diffuse = SelectedColor
        else
            shape.active = false
        end
    end
end
