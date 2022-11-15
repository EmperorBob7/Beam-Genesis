extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and get_parent().find_node("Player").hasBattery:
		var i = int(name)
		var light = get_parent().find_node("Beam" + str(i))
		if not light.visible:
			get_parent().find_node("Player").hasBattery = false
			light.visible = true
			light.set_collision_layer_bit(0, true)	
		$AudioStreamPlayer2D.play()
