----------------------------------------------------------------
-- Shapes and Colors :: 
-- Part 3: Camera Control - Adjusting camera distance
-- Goal: Add a parameter to control the camera distance along the negative Z-axis.
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
    
    -- Parameter to change camera distance
    parameter.integer("CameraDistance", 1, 3, 1)
    
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
    
    -- Adjust camera position based on parameter
    scene.camera.position = vec3(0, 0, -5 * CameraDistance)
    
    scene:draw()
    
    for i, shape in ipairs(shapes) do
        if i == Shape then
            shape.active = true
            shape:get(craft.renderer).material.diffuse = SelectedColor
        else
            shape.active = false
        end
    end
end
