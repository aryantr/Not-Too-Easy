extends KinematicBody2D

var change_cam : bool = false
var on_floor : bool = false
var score
var velocity : Vector2 = Vector2.ZERO

export (int) var jump_speed = -680
export (int) var gravity = 1200

func _ready():
	score = 0

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_floor():
		$Area2D.set_deferred("monitoring",true)
	else:
		$Area2D.set_deferred("monitoring",false)
	
	if Input.is_action_just_pressed("ui_up") or Input.is_mouse_button_pressed(BUTTON_LEFT):
		if is_on_floor():
			velocity.y = jump_speed

func _on_Area2D_body_entered(body):
	if body.is_in_group("platforms"):
		if not body.get_parent() in get_parent().platforms:
			get_parent().platforms.append(body.get_parent())
			score += 1
			saveload.add_latest_score(score - 1)
			get_parent().get_node("CanvasLayer/score").text = "SCORE  :" + str(score - 1)
		if get_parent().platforms.size() > 5:
			print("WARNING : changing camera position")
			change_cam = true
			get_parent().get_node("Camera2D/Area2D").set_deferred("monitoring",true)


func _on_Area2D_body_exited(_body):
	pass


func _on_exit_notifier_screen_exited():
	saveload._save_score(score-1)
	yield(get_tree().create_timer(0.5), "timeout")
	if get_tree().change_scene_to(load("res://scenes/Menu.tscn")) != 0:
		get_tree().quit()
