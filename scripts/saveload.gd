extends Node

var location = "user://save.data"
var load_score

var latestscore

var password = "getwellbro"
#var password = "getwellbro"

func _save_score(score): #save score
	var data = {
		"score" : score
	}
	var file = File.new()
	if file.file_exists(location):
		file.open_encrypted_with_pass(location, File.READ,password)
		var opened = parse_json(file.get_as_text())
		file.open_encrypted_with_pass(location, File.WRITE,password)
		score = check_score(score,opened["score"])
		data["score"] = score
		file.store_line(to_json(data))
		file.close()
	else:
		_create_file(score)

func _create_file(score):
	var file = File.new()
	if(file.open_encrypted_with_pass(location, File.WRITE,password) != 0):#check storage permission
		print("Error storing..permission not granted\nUpdate ",OS.get_user_data_dir()," permission to save score")
		OS.alert("Grant permission for storing save game","Really!!")
	else:
		var data = {
			"score" : score
		}
		file.store_line(to_json(data))
		file.close()

func load_game_score():
	var file = File.new()
	var score = 0
	if file.file_exists(location):
		print("save file exsists in ",OS.get_user_data_dir())
		file.open_encrypted_with_pass(location,File.READ,password)
		var data = parse_json(file.get_as_text())
		score = data["score"]
		file.close()
	else:
		file.close()
		print("creating new save file in ",OS.get_user_data_dir())
		_create_file(score)
	return score

func check_score(current_score,saved_score): #Compare saved score and current score
	if(current_score > saved_score):
		return current_score
	return saved_score

func add_latest_score(s):
	latestscore = s

func get_latest_score():
	return latestscore
