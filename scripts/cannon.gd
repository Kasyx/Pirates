extends Sprite2D

@onready var muzzle = $Muzzle
@onready var rng = RandomNumberGenerator.new()

const CANNONBALL = preload("res://scenes/cannonball.tscn")

func fire(deviation = 2):
	var ci = CANNONBALL.instantiate()
	ci.global_transform = muzzle.global_transform
	ci.rotation_degrees += rng.randfn (0, deviation)
	get_tree().get_root().add_child(ci)
	
