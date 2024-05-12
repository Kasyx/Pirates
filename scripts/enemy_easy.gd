extends RigidBody2D

var life = 100

@onready var hull_sprite = $HullSprite
@onready var hull_sprite_stage_2 = $HullSpriteStage2
@onready var hull_sprite_stage_3 = $HullSpriteStage3
@onready var cannon = $Cannon

func receive_hit(dmg):
	life -= dmg
	print("Remaining life: " + str(life))
	
	if life <= 0:
		queue_free()
	elif life < 30:
		hull_sprite.texture = hull_sprite_stage_3.texture
	elif life < 70:
		hull_sprite.texture = hull_sprite_stage_2.texture
	
	
func _on_salvo_timer_timeout():
	cannon.fire(2.5)
