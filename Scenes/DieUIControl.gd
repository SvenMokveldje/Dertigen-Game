extends Control

signal dieSelected(value)
var selected = false
@onready var background = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var bounds = Rect2(background.global_position, background.size)
		if bounds.has_point(event.position):
			match selected:
				true:
					selected = false
				false:
					selected = true
			dieSelected.emit(selected)
		
