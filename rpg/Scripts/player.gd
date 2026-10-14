extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var last_direction: Vector2 = Vector2.RIGHT
const SPEED = 300.0

func _physics_process(delta: float) -> void:
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
	 
