extends Node2D

@onready var health: Sprite2D = $Health
@onready var slime: CharacterBody2D = $".."



func _process(delta: float) -> void:
	var healthbar=slime.health
	print(healthbar)
	var healthbar_percentage= (18*healthbar)/100
	health.region_rect.size.x = healthbar_percentage
	
