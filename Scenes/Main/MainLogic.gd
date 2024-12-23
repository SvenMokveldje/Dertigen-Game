extends Node2D

signal youDrink(value) 
signal youChug

enum GameStates {THROW, SELECT, AFTER, RETHROW}
var currentGameState = GameStates.THROW
var dicesLeft = 6
var diceSelected = false
var selectedDice: Array[Node] = []
var pickedDice: Array[Node] = []

@onready var selectButton = $Control/Pick
@onready var pickedDicesNode = $"Picked Dice Positions"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectButton.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") && !currentGameState == GameStates.AFTER:
		roundLogic()
	elif currentGameState == GameStates.AFTER:
		afterRoundLogic()
	#if Input.is_action_just_pressed("click") && currentGameState == GameStates.RETHROW:
		#get_tree().call_group("Dice", "throwDie")
		#get_tree().call_group("Dice", "selectDice", true)
	
# Check the game state and apply the correct function
func roundLogic():
	match currentGameState:
		GameStates.THROW:
			throwRound()
			currentGameState = GameStates.SELECT
		GameStates.SELECT:
			pass

# Apply a throwing round
func throwRound():
	get_tree().call_group("Dice", "throwDie")

#region dice selection
func setDiceSelected(selected: bool, dices: Array[Node]) -> void:
	diceSelected = selected
	selectedDice = dices
	selectButton.visible = selected

func _on_pick_pressed() -> void:
	pickedDice = selectedDice
	selectedDice = []
	
	var firstOpen = pickedDicesNode.freeLocations.find(true)
	var locations = pickedDicesNode.locations
	for i in pickedDice.size():
		pickedDice[i].position = locations[i + firstOpen].position
		pickedDicesNode.freeLocations[i + firstOpen] = false
		
		pickedDice[i].canThrow = false
		dicesLeft -= 1
		pickedDicesNode.pickedDice.append(pickedDice[i]) 
	
	pickedDice = []
	diceSelected = false
	selectButton.visible = diceSelected
	if	dicesLeft == 0:
		currentGameState = GameStates.AFTER
		return
	else:
		currentGameState = GameStates.THROW
#endregion

#region after round logic
func afterRoundLogic() -> void:
	var amount = pickedDicesNode.amount
	if amount > 30:
		reThrow(amount - 30)
	elif amount == 30:
		youChug.emit()
	elif amount < 30 && amount > 10:
		youDrink.emit(30-amount)
	else:
		pass

func reThrow(val: int) -> void:
	reset()
	get_tree().call_group("Dice", "setReThrowNumber", val)
	currentGameState = GameStates.THROW
			
func _on_drank_pressed() -> void:
	reset()

#endregion

func reset() -> void:
	get_tree().call_group("Dice", "reset")
	currentGameState = GameStates.THROW
	dicesLeft = 6
	diceSelected = false
	selectedDice = []
	pickedDice = []
