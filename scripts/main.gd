extends Node2D

onready var tween = $Tween
onready var camera = $Camera2D
onready var label = $CanvasLayer/Label

var platforms : Array = []

func set_platforms():
	var size_platform = platforms.size() - 1
	if platforms:
		for _i in range(size_platform):
			platforms[0].position.y -= 2496
			platforms.pop_front()
	return

func _on_Area2D_body_entered(body):
	if body.name == 'player':
		var next_position =  Vector2(360,camera.position.y - (192*5))
		tween.interpolate_property(camera,'position',camera.position,next_position,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()

func _on_Tween_tween_completed(_object, _key):
	$Camera2D/Area2D.set_deferred("monitoring",false)
	set_platforms()
