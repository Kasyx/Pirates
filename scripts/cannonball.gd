extends Area2D

const FIRE_FORCE = 750
@export var dmg = 10

@onready var timer = $Timer
	
func _physics_process(delta):
	position += transform.x * FIRE_FORCE * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	body.receive_hit(dmg)
	queue_free()
