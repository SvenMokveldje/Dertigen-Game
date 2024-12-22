extends Node2D

var currentNum = 1
@onready var dieText =  $DieNumber

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		currentNum = randi() % 6 + 1
		dieText.text = str(currentNum)
