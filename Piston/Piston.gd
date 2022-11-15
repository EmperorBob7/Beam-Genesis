extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const UP = Vector2(0, -1)
var canGo = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and canGo:
		canGo = false
		$AudioStreamPlayer2D.play()
		var player: KinematicBody2D = get_parent().find_node("Player")
		var vX = 50000 * cos(-rotation)
		var vY = 50000 * sin(-rotation)
		player.isPushed = true
		player.motion = player.move_and_slide(Vector2(vX, vY), UP)
		$Sprite.texture = load("res://Piston/Piston2.png")
		$Sprite.offset.x = 32
		yield(get_tree().create_timer(2.0), "timeout")
		canGo = true
		$Sprite.texture = load("res://Piston/Piston1.png")
		$Sprite.offset.x = 0
		player.isPushed = false
