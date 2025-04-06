-- Called once at the start to initialize the program
function setup()
    -- Create a new 3D scene
    scene = craft.scene()
    
    -- Position the camera behind the shapes to view them
    scene.camera.position = vec3(0, 0, -5)
    
    -- Add a directional light to illuminate the scene
    local light = scene:entity()
    light:add(craft.light, DIRECTIONAL)
    light.rotation = quat.eulerAngles(45, 45, 0) -- Point the light downwards at an angle
    
    -- Paramter to change the distance of the camera
    parameter.integer("CameraDistance", 1, 3, 1)
    
    -- Default color for all shapes
    defaultColor = color(255, 255, 255, 255) -- White
    
    -- Parameter to switch between shapes (1 = cube, 2 = sphere, 3 = small cube)
    parameter.integer("Shape", 1, 3, 1)

    -- Rotate the shapes
    parameter.number("Rotation", 0, 360, 0)
        
    -- Parameter to select a color
    parameter.color("SelectedColor", defaultColor)
    
    -- Button to assign the selected color to the active shape
    parameter.action("Assign Color", assignColor)
    
    -- Button to reset colors on the shapes
    parameter.action("Reset Colors", function() shapeColors = {} end)
    
    -- Create the shapes
    createShapes()
    
    -- Initialize an empty table for color assignments
    shapeColors = {}
end

-- Function to create the three shapes
function createShapes()
    shapes = {} -- Table to store all shapes
    
    -- Create a cube
    local cube = scene:entity()
    local cubeMaterial = craft.material(asset.builtin.Materials.Standard)
    cube:add(craft.renderer, craft.model.cube(vec3(1, 1, 1)))
    cube:get(craft.renderer).material = cubeMaterial
    cube.position = vec3(0, 0, 0)
    table.insert(shapes, cube)
    
    -- Create a sphere
    local sphere = scene:entity()
    local sphereMaterial = craft.material(asset.builtin.Materials.Standard)
    sphere:add(craft.renderer, craft.model.icosphere(0.5, 2))
    sphere:get(craft.renderer).material = sphereMaterial
    sphere.position = vec3(0, 0, 0)
    table.insert(shapes, sphere)
    
    -- Create a small cube
    local smallCube = scene:entity()
    local smallCubeMaterial = craft.material(asset.builtin.Materials.Standard)
    smallCube:add(craft.renderer, craft.model.cube(vec3(0.5, 0.5, 0.5)))
    smallCube:get(craft.renderer).material = smallCubeMaterial
    smallCube.position = vec3(0, 0, 0)
    table.insert(shapes, smallCube)
end

-- Function to assign the selected color to the active shape
function assignColor()
    if Shape >= 1 and Shape <= 3 then
        -- Assign the selected color to the current shape in the table
        shapeColors[Shape] = SelectedColor
        -- Update the active shape's color immediately
        shapes[Shape]:get(craft.renderer).material.diffuse = SelectedColor
    end
end

-- Called every frame to update and render the scene
function draw()
    -- Update the scene with the time since the last frame
    scene:update(DeltaTime)
    
    -- Set the background to black
    background(0, 0, 0, 255)
    
    -- Render the scene
    scene:draw()
    
    -- Adjust the camera
    scene.camera.position = vec3(0, 0, -5*CameraDistance)
    
    -- Show only the active shape and set its color
    for i, shape in ipairs(shapes) do
        if i == Shape then
            shape.active = true
            -- Use the assigned color if it exists in the table, otherwise use default
            local currentColor = shapeColors[i] or SelectedColor
            shape:get(craft.renderer).material.diffuse = currentColor
            
            -- Rotation of the shape
            shape.rotation = quat.eulerAngles(0, Rotation, 0)
        else
            shape.active = false
        end
    end
end
