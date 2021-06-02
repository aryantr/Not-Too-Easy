extends Node2D

onready var tween = $camera_tween
onready var camera = $Camera2D
#onready var label = $CanvasLayer/Label

var platforms : Array = []

func _ready():
	print($Camera2D/Area2D.is_monitoring())

func set_platforms():
	if platforms:
		var size_platform = platforms.size() - 1
		for _i in range(size_platform):
			platforms[0].reset_platforms()
			platforms[0].position.y -= 2100
			platforms.pop_front()
			print(platforms[0].name)
	return

func _on_Area2D_body_entered(body):
	if body.name == 'player':
		if body.change_cam:
			var next_position =  camera.position + (Vector2.UP * 750)
			body.change_cam = false
			tween.interpolate_property(camera,'position',camera.position,next_position,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN)
			tween.start()


func _on_camera_tween_tween_started(_object, _key):
	$Camera2D/Area2D.set_deferred("monitoring",false)
	return
	
	
func _on_camera_tween_tween_completed(_object, _key):
	yield(get_tree().create_timer(1.0), "timeout")
	set_platforms()
	return
