extends Control
@onready var text: RichTextLabel = $Text
var label_text: String = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text.text = label_text

func dialog1() -> void:
	visible = true
	label_text = 'Hello there Traveler, welcome to our humble RPG'


func _on_button_pressed() -> void:
	label_text = 'Okay, Please walk down the road and meet my friend there'
