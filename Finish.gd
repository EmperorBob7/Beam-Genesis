extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Finish_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://Levels/Level" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
