extends Button
export (String) var action_name = ""

var do_set = false

func _pressed():
	text = ""
	do_set = true

func _input(event):
	if(event is InputEventKey and do_set):
		var newkey = InputEventKey.new()
		newkey.scancode = int(Keys.key_dict[action_name])
		InputMap.action_erase_event(action_name,newkey)
		#Add the new key for this action
		InputMap.action_add_event(action_name,event)
		#Show it as readable to the user
		text = OS.get_scancode_string(event.scancode)
		#Update the keydictionary with the scanscode to save
		Keys.key_dict[action_name] = event.scancode
		#Save the dictionary to json
		#stop setting the key
		do_set = false
