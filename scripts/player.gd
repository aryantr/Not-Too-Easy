extends RigidBody2D

var on_floor : bool
var fix_position : Vector2
var fixer
var menu_scene

var score
#to check the player in top of the platform
onready var ray = [$Raycaster/Left,$Raycaster/Right]
onready var main_node = get_parent()

func _ready():
	score = 0
	menu_scene = load("res://scenes/Menu.tscn")
	
func _physics_process(delta):

	#if player is reached on the platform, fix it's position to the platform
	if on_floor:
		position = fixer.global_position

func _integrate_forces(_state):
	if (Input.is_action_just_pressed("ui_up") or Input.is_mouse_button_pressed(BUTTON_LEFT) ):
		if on_floor:
			set_physics_process(false)
			
			#due to rigidbody, jump is acheived using linear velocity in y direction
			set_linear_velocity(Vector2.UP * 850)
			print(get_linear_velocity())
			on_floor = false
			fixer = null

func _on_player_body_entered(body):
	if ray[0].is_colliding() or ray[1].is_colliding():
		var collider = ray[0].get_collider() if ray[0].is_colliding() else ray[1].get_collider()
#		print(collider)
		if collider.is_in_group('platforms'):
			if !(body in main_node.platforms):
				main_node.platforms.append(body)
				score += 1
				main_node.get_node("CanvasLayer/Label").text = "score : " + str(score - 1) 
				if main_node.platforms.size() > 5:
					if body == main_node.platforms[5]:
						
						main_node.get_node("Camera2D/Area2D").set_deferred("monitoring",true)
			
			fixer = body.get_node("fixer")
			fixer.global_position = position
			on_floor = true
			set_physics_process(true)
	else:
		on_floor = false
		set_physics_process(false)

func _on_VisibilityNotifier2D_screen_exited():
	saveload._save_score(score-1)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene_to(menu_scene)
