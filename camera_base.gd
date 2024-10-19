extends Camera3D
# other camera scripts can inherit from this
# they must call the base_camera_process at the top of their _process method

var mouse_pressed_prev = false
var weapon = 1
const BASE_FOV = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func base_camera_process():
	# screen shake
	fov = BASE_FOV + randf_range(0.0, Data.shaking_amt)
	
	# inputs
	if Input.is_action_pressed("Click"):
		Data.current_weapon = Data.Weapon.CLICK
	if Input.is_action_pressed("flamethrower"):
		Data.current_weapon = Data.Weapon.FLAMETHROWER
	
	# destroy destructables
	var cam = get_viewport().get_camera_3d()
	var space_state = get_world_3d().direct_space_state
	var mpos_2d = get_viewport().get_mouse_position()
	var raycast_origin = cam.project_ray_origin(mpos_2d)
	var raycast_end = cam.project_position(mpos_2d, 1000)
	var query = PhysicsRayQueryParameters3D.create(raycast_origin, raycast_end)
	var intersect = space_state.intersect_ray(query)
	if intersect.size() > 0:
		if Data.current_weapon == Data.Weapon.CLICK:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				if not mouse_pressed_prev:
					if intersect.collider.get_parent().has_meta("destructable"):
						intersect.collider.get_parent().explode()
						
		if Data.current_weapon == Data.Weapon.FLAMETHROWER:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				if intersect.collider.get_parent().has_meta("destructable"):
					intersect.collider.get_parent().burn()
						
	
	mouse_pressed_prev = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
