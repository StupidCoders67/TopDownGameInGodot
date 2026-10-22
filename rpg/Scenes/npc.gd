extends CharacterBody2D

var player_entered = false
func _physics_process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print('player entered')


func _on_area_2d_body_exited(body: Node2D) -> void:
	print('player exited')
