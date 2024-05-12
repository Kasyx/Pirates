extends CharacterBody2D

var life = 100

var speed_level = 0
var current_speed = 0

const MAX_SPEED_LEVEL = 3
const SPEED_PER_LEVEL = 3000
const ROTATION_SPEED_PER_S = 25
const ACCELERATION = SPEED_PER_LEVEL/3

@onready var sail = $Sail
@onready var cannons_left = $CannonsLeft
@onready var cannons_right = $CannonsRight

const CANNONBALL = preload("res://scenes/cannonball.tscn")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_just_pressed("increase_speed") && speed_level < MAX_SPEED_LEVEL:
		speed_level += 1
		print("Speed level: " + str(speed_level))
	elif Input.is_action_just_pressed("decrease_speed") && speed_level > 0:
		speed_level -= 1
		print("Speed level: " + str(speed_level))
		
	if Input.is_action_pressed("turn_right"):
		rotation_degrees += ROTATION_SPEED_PER_S * delta
	elif Input.is_action_pressed("turn _left"):
		rotation_degrees -= ROTATION_SPEED_PER_S * delta
		
	sail.scale.y = 0.3 + speed_level*0.4
	
	if Input.is_action_just_pressed("fire"):
		fire()
	
func _physics_process(delta):
	
	current_speed = calculate_new_speed(ACCELERATION * delta)
	velocity = Vector2(current_speed *  delta, 0).rotated(rotation)
	#velocity = Vector2(SPEED_PER_LEVEL * speed_level *  delta, 0).rotated(rotation)
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func calculate_new_speed(accelerationWithDelta):
	var desired_speed = speed_level * SPEED_PER_LEVEL
	
	if current_speed < desired_speed:
		var proposed_speed = current_speed + accelerationWithDelta
		if proposed_speed > desired_speed:
			proposed_speed = desired_speed
		return proposed_speed
		
	if current_speed > desired_speed:
		var proposed_speed = current_speed - accelerationWithDelta
		if proposed_speed < desired_speed:
			proposed_speed = desired_speed
		return proposed_speed
		
	return current_speed
		

func fire():
	var mouse_pos = get_local_mouse_position()
	
	if mouse_pos.y <= 0:
		fire_salvo(cannons_left.get_children())
	else:
		fire_salvo(cannons_right.get_children())
	

func fire_salvo(cannons):
	for cannon in cannons:
		cannon.fire()
	
		
func receive_hit(dmg):
	life -= dmg
	print("Remaining life: " + str(life))
	
	if life <= 0:
		queue_free()
	elif life < 30:
		pass
		#hull_sprite.texture = hull_sprite_stage_3.texture
	elif life < 70:
		pass
		#hull_sprite.texture = hull_sprite_stage_2.texture
	
