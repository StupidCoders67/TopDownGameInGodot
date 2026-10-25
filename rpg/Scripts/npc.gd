extends CharacterBody2D
@onready var label: RichTextLabel = null
@onready var dialog: Control = null
var player = null

var player_entered = false
func _physics_process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		player_entered = true
		player = body
		label = player.get_node("Dialog/RichTextLabel")
		dialog = player.get_node("Dialog")
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		player_entered = false

func dialog1() -> void:
	if dialog and label:
		dialog.visible = true
		label.text = 'Hello there Traveler, welcome to our humble RPG'
