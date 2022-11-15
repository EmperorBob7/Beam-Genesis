extends KinematicBody2D
export(Vector2) var UP = Vector2(0, -1)
#const UP = Vector2(0, -1)
const RUN_VECTOR = Vector2(1.05, 0.95)
const IDLE = Vector2(0.95, 0.95)
const IDLE_OFFSET = Vector2(0, 0)

const GRAVITY = 45
const SPEED = 300
const JUMP = 900
const ACCEL = 40

var motion = Vector2()
var hasBattery = false
var isPushed = false

func getBattery():
	hasBattery = true
	$ChargeSFX.play()

func _physics_process(delta):
	if global_position.y > 1080 or global_position.y < 0:
		get_tree().reload_current_scene()
	var slopeResist = get_floor_normal() if is_on_floor() else UP
	motion -= GRAVITY * slopeResist
	motion.x = clamp(motion.x, -SPEED, SPEED)
	
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		$AnimationPlayer.stop()
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		$AnimationPlayer.stop()
	elif not isPushed:
		motion.x = lerp(motion.x, 0, 0.05)
		$AnimationPlayer.play("Idle")
	if is_on_floor() or is_on_ceiling() and UP.y == 1:
		var v = get_floor_normal()
		$Sprite.rotation = atan2(v.x, -v.y)
		$CollisionShape2D.rotation = atan2(v.x, -v.y)
		if Input.is_action_pressed("up"):
			motion.y += JUMP * UP.y
			$AnimationPlayer.play("Jump")
	else:
		$AnimationPlayer.stop()	
	motion = move_and_slide(motion, UP, true)
	var offset = -30.45 * UP.y
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.get_parent().name.begins_with("Switch"):
			
			if collision.position.y > $CollisionShape2D.global_position.y + offset:
				$ButtonSFX.play()
				var i = int(collision.collider.get_parent().name)
				var light = get_parent().find_node("Light" + str(i))
				light.visible = true
				light.set_collision_layer_bit(0, true)
				collision.collider.queue_free()
		elif collision.collider.get_parent().name.begins_with("OffSwitch"):
			if collision.position.y > $CollisionShape2D.global_position.y + offset:
				print("OFF")
				$ButtonSFX.play()
				var i = int(collision.collider.get_parent().name)
				var light = get_parent().find_node("Light" + str(i))
				light.visible = false
				light.set_collision_layer_bit(0, false)
				collision.collider.queue_free()
