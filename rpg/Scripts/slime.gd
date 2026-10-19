extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var take_damage_sound: AudioStreamPlayer2D = $"Take damage"

const SPEED: int = 50.0
const KNOCKBACK_FORCE: int = 100
var target = null
var health: int = 100
var is_alive: bool = true

func _physics_process(delta: float) -> void:
	if target and is_alive:
		_attack(delta)
	move_and_slide()
	
func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
	animated_sprite_2d.play("attack")

func take_damage(damage: int, attacker_position: Vector2) -> void:
	health -= damage
	print(health)
	if health <= 0:
		_die()
	else:
		take_damage_sound.play()
		#KnockBack
		var knockback_direction = (position - attacker_position).normalized()
		var target_position = position + knockback_direction * KNOCKBACK_FORCE
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self,'position', target_position, 0.5)
		
func _die() -> void:
	is_alive = false
	animated_sprite_2d.play('Death')
	take_damage_sound.pitch_scale = 0.5
	take_damage_sound.play()
	await get_tree().create_timer(0.5).timeout
	var tween= create_tween()
	tween.tween_property(self, 'modulate:a', 0.0, 1.0)
	await get_tree().create_timer(1).timeout
	queue_free()
	
func _on_sight_body_entered(body: Node2D) -> void:
	if body.name =='Player':
		print("player detected")
		target = body 


func _on_sight_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		target = null
		animated_sprite_2d.play("idle")
