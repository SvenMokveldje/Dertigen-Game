extends Node2D

var currentNum = 1
var selected = false
@onready var dieText =  $Control/Label	
@onready var dieBackground = $Control/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dieText.text = str(currentNum)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		currentNum = randi() % 6 + 1
		dieText.text = str(currentNum)
	
func _on_control_die_selected(value: Variant) -> void:
	selected = value 
	
	if selected:
		dieBackground.color = Color.WEB_GRAY
	elif !selected:
		dieBackground.color = Color.WHITE_SMOKE
		
