extends KinematicBody2D

var direction = {
				'0' : Vector2.LEFT,
				'1' : Vector2.RIGHT
}

var where_to
var move_to

var speed = 100

func _ready():
	set_physics_process(false)
	randomize()
	where_to = str(randi() % direction.size())
	move_to = direction[where_to]
	speed = randi() % 200 + 150
	set_physics_process(true)
	
func _physics_process(delta):
	if position.x >= 632:
		move_to = direction['0'] 
	elif position.x <= 80:
		move_to = direction['1']
		
	move_and_slide_with_snap(move_to * speed, Vector2.UP * 15)
