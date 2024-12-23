extends Node

var freeLocations: Array[bool]
var locations: Array[Node]

var pickedDice: Array[Node]

var amount = 0

@onready var amountLabel = $"../Control/Amount"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()
	locations = self.get_children()
	amountLabel.text = str(amount)

func reset() -> void:
	freeLocations = []
	freeLocations.resize(6)
	freeLocations.fill(true)
	pickedDice = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# On pick pressed change the amount label
func _on_pick_pressed() -> void:
	amount = 0
	for die in pickedDice:
		amount += die.currentNum
	
	amountLabel.text = str(amount)


func _on_drank_pressed() -> void:
	amount = 0
	amountLabel.text = str(amount)
	reset()
