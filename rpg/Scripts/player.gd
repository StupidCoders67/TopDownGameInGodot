extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: Vector2 = Vector2.RIGHT
var is_attacking: bool = false

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
	if is_attacking:
		velocity = Vector2.ZERO
		return
	process_movement()
	move_and_slide()


func process_movement() -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO
	process_animation(last_direction)



func process_animation(direction) -> void:
	if is_attacking:
		return
	if velocity != 	Vector2.ZERO:
		player_animation("walk", direction)
	else:
		player_animation("idle", direction)



func player_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
		
func attack() -> void:
	is_attacking = true
	player_animation("attack", last_direction)
	print("attack")
	 


func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false
