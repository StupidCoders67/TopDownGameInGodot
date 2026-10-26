extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_swing: AudioStreamPlayer2D = $SwordSwing
@onready var hitbox: Area2D = $Hitbox
@onready var interact_with_npc: Control = $"Interact with NPC"
@onready var npc: CharacterBody2D = $"../NPC"
@onready var dialog: Control = $Dialog


var last_direction: Vector2 = Vector2.RIGHT
var is_attacking: bool = false
var hitbox_offset: Vector2
var strength: int = 20

const SPEED = 300.0

func _ready() -> void:
	hitbox_offset = hitbox.position

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
	if is_attacking:
		velocity = Vector2.ZERO
		return
	process_movement()
	move_and_slide()
	update_hitbox()
	_interact_with_NPC()
	if interact_with_npc.visible and Input.is_action_just_pressed("Interact"):
		dialog.dialog1()
#--------------------------------------------------------------------------------
#MOVING
#--------------------------------------------------------------------------------
func process_movement() -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	if direction != Vector2.ZERO and dialog.dialog_happening:
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
#--------------------------------------------------------------------------------
#Attacking
#--------------------------------------------------------------------------------		
func attack() -> void:
	is_attacking = true
	hitbox.monitoring = true
	sword_swing.play()
	player_animation("attack", last_direction)

func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false
	hitbox.monitoring = false

#--------------------------------------------------------------------------------
#Hitbox_offset
#--------------------------------------------------------------------------------
func update_hitbox() -> void:
	var x = hitbox_offset.x
	var y = hitbox_offset.y
	match last_direction:
		Vector2.RIGHT:
			hitbox.position = Vector2(x, y)
		Vector2.LEFT:
			hitbox.position = Vector2(-x, y)
		Vector2.UP:
			hitbox.position = Vector2(y, -x)
		Vector2.DOWN:
			hitbox.position = Vector2(-y, x)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if is_attacking and body.name.begins_with("Slime"):
		body.take_damage(strength, position)
#--------------------------------------------------------------------------------
#NPC Interaction
#--------------------------------------------------------------------------------
func _interact_with_NPC() -> void:
	if npc.player_entered:
		interact_with_npc.visible = true
	else:
		interact_with_npc.visible = false
		
		
	
	

	
