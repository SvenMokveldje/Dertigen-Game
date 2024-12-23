extends Node2D

enum GameStates {THROW, SELECT}
var currentGameState
var dicesLeft

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dicesLeft = 6
	currentGameState = GameStates.THROW

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		roundLogic()
	
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
	
func selectRound():
	pass
	
