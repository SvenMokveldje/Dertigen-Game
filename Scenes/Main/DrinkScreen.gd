extends Control

@onready var drinkLabel = $Label
@onready var drankButton = $Drank

var youDrinkText = "You drink: "
var youChug = "You chug your drink!!!"
var anotherDrinksText = "Person drinks: "

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

func _on_main_you_drink(value: Variant) -> void:
	self.visible = true
	drinkLabel.text = youDrinkText + str(value)


func _on_drank_pressed() -> void:
	self.visible = false


func _on_main_you_chug() -> void:
	self.visible = true
	drinkLabel.text = youChug
