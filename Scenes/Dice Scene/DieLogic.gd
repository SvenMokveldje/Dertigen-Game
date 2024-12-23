extends Node2D

signal dieSelected(value)

var currentNum = 1
var selected = false
var canThrow = true

var reThrowNumber

var startPosition

@onready var dieText =  $Control/Label	
@onready var dieBackground = $Control/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reThrowNumber = 0
	startPosition = self.position
	dieText.text = str(currentNum)

func throwDie() -> void:
	if canThrow:
		currentNum = randi() % 6 + 1
		dieText.text = str(currentNum)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#region die selection
# Change die color on selection
func _on_control_die_selected(value: Variant) -> void:
	var mainNode = get_parent()
	
	if !mainNode.diceSelected:
		selectDice(value)
	elif mainNode.diceSelected && self in mainNode.selectedDice:
		selectDice(value)

# Swap the background of the dice
func swapBackground(selected: bool) -> void:
	if selected:
		dieBackground.color = Color.WEB_GRAY
	elif !selected:
		dieBackground.color = Color.WHITE_SMOKE
		
# Set the dice of the same numbers to selected
func selectDice(val: bool)-> void:
	var dice = get_tree().get_nodes_in_group("Dice")
	var dices: Array[Node] = []
	for die in dice:
		if reThrowNumber != 0: 
			if die.currentNum == reThrowNumber && die.canThrow:
				die.selected = val
				die.swapBackground(val)
				dices.append(die)
		else:
			if die.currentNum == self.currentNum && die.canThrow:
				die.selected = val
				die.swapBackground(val)
				dices.append(die)
			
	get_parent().setDiceSelected(val, dices)	
#endregion

func setReThrowNumber(val: int) -> void:
	reThrowNumber = val

func reset() -> void:
	currentNum = 1
	dieText.text = str(currentNum)
	selected = false
	canThrow = true
	self.position = startPosition
	self.swapBackground(false)
	reThrowNumber = 0
	
