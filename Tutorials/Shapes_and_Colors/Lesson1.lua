----------------------------------------------------------------
-- Shapes and Colors :: Part 1: Displaying a single shape
-- Goal: Introduce the basic structure of a Codea program and 
--       display a single cube with a default color
----------------------------------------------------------------

-- Called once at the start to initialize the program
function setup()
    -- Create a new 3D scene
    scene = craft.scene()
    
    -- Position the camera to view the shape
    scene.camera.position = vec3(0, 0, -5)
    
    -- Add a directional light to illuminate the scene
    local light = scene:entity()
    light:add(craft.light, DIRECTIONAL)
    light.rotation = quat.eulerAngles(45, 45, 0)
    
    -- Create a cube
    local cube = scene:entity()
    local cubeMaterial = craft.material(asset.builtin.Materials.Standard)
    cube:add(craft.renderer, craft.model.cube(vec3(1, 1, 1)))
    cube:get(craft.renderer).material = cubeMaterial
    cube.position = vec3(0, 0, 0)
    cube:get(craft.renderer).material.diffuse = color(255, 255, 255, 255) -- White
end

-- Called every frame to update and render the scene
function draw()
    -- Update the scene
    scene:update(DeltaTime)
    
    -- Set the background to black
    background(0, 0, 0, 255)
    
    -- Render the scene
    scene:draw()
end
