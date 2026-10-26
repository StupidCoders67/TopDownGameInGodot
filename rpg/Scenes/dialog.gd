extends Control
@onready var text: RichTextLabel = $Text
var label_text: String = ''
@onready var button_2: Button = $Control/Button2
@onready var button_3: Button = $Control/Button3
@onready var button: Button = $Control/Button
var dialog_counter: int = 0 
var dialog_happening: bool = true

func _process(delta: float) -> void:
	text.text = label_text

func dialog1() -> void:
	dialog_happening = false
	visible = true
	label_text = 'Hello there Traveler, welcome to our humble RPG'
	button_2.visible = false
	button_3.visible = false
	button.text = 'Hello, There'


func _on_button_pressed() -> void:
	dialog_counter += 1
	if dialog_counter == 1:
		label_text = 'Okay, Please walk down the road and meet my friend there'
		button.text = 'Thank you'
	elif dialog_counter == 2:
		visible = false
		dialog_happening = true
		dialog_counter = 0
		 
	
