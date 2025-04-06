-- Called once at the start to initialize the program
function setup()
    -- Create a new 3D scene
    scene = craft.scene()
    
    -- Position the camera to view the shapes
    scene.camera.position = vec3(0, 0, -5)
    
    -- Add a directional light to illuminate the scene
    local light = scene:entity()
    light:add(craft.light, DIRECTIONAL)
    light.rotation = quat.eulerAngles(45, 45, 0) -- Point the light downwards at an angle
    
    -- Parameter to switch between shapes (1 = cube, 2 = sphere, 3 = small cube)
    parameter.integer("Shape", 1, 3, 2)
    
    -- Parameter to change the color of the active shape
    parameter.color("Color", color(255, 255, 255, 255)) -- Default is white
    
    -- Paramter to change the distance of the camera
    parameter.integer("CameraDistance", 1, 3, 1)
    
    -- Create the shapes
    createShapes()
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

-- Called every frame to update and render the scene
function draw()
    -- Update the scene with the time since the last frame
    scene:update(DeltaTime)
    
    -- Set the background to black
    background(0, 0, 0, 255)
    
    -- Render the scene
    scene:draw()
    
    -- Show only the active shape and set its color
    for i, shape in ipairs(shapes) do
        if i == Shape then
            shape.active = true
            shape:get(craft.renderer).material.diffuse = Color
        else
            shape.active = false
        end
    end
    
    -- Adjust the camera
    scene.camera.position = vec3(0, 0, -5*CameraDistance)
end
