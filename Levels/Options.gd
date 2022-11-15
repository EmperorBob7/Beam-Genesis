extends CanvasLayer

var file_name = "res://keybinding.json"

var setting_key = false

func _ready():
	if get_child(0).visible == true:
		load_keys()
		get_child(0).visible = false
		get_child(1).visible = false

func _process(delta):
	if(get_tree().current_scene.name.begins_with("keybinding")):
		get_child(0).visible = true
		get_child(1).visible = true
	pass

#We'll use this when the game loads
func load_keys():
	var data = {"left":65, "right":68, "up":87}
	Keys.key_dict = data
	setup_keys()
	
func delete_old_keys():
	#Remove the old keys
	for i in Keys.key_dict:
		var oldkey = InputEventKey.new()
		oldkey.scancode = int(Keys.key_dict[i])
		InputMap.action_erase_event(i,oldkey)

func setup_keys():
	for i in Keys.key_dict:
		for j in get_tree().get_nodes_in_group("button_keys"):
			if(j.action_name == i):
				j.text = OS.get_scancode_string(Keys.key_dict[i])
		var newkey = InputEventKey.new()
		newkey.scancode = int(Keys.key_dict[i])
		InputMap.action_add_event(i,newkey)
	
func save_keys():
	var file = File.new()
	file.open(file_name,File.WRITE)
	file.store_string(to_json(Keys.key_dict))
	file.close()
	print("saved")
	pass


func _on_Button_pressed():
	find_node("GridContainer").visible = false
	find_node("Button").visible = false
	get_tree().change_scene("res://Levels/Menu.tscn")
