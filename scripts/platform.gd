extends Node2D

var max_speed = 1
var min_speed = 3

func _ready():
	reset_platforms()

func reset_platforms():
	if $AnimationPlayer.is_playing():
		print("stop animation")
		$AnimationPlayer.stop(true)
	randomize()
	var speed = (randi() % max_speed + min_speed) + randf()
	randomize()
	if(randi() % 2):
		$AnimationPlayer.play("move",0,-(speed),true)
		return
	$AnimationPlayer.play("move",0,speed)
