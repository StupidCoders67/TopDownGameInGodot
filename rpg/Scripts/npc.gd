extends CharacterBody2D

var player_entered = false
func _physics_process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		player_entered = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		player_entered = false
