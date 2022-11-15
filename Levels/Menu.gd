extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_tree().get_node_count())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")



func _on_Options_pressed():
	get_tree().change_scene("res://Levels/Options.tscn")

func _on_Quit_pressed():
	get_tree().quit()
