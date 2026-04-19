extends Control

@export var archive_id: int = 1
@export var archive_title: String = "Lasillans.png"

func _ready():
	if GameState.symbols_discovered.has("lasillan"):
		_on_lasillan_pressed()
	if GameState.symbols_discovered.has("large"):
		_on_large_pressed()
	if GameState.symbols_discovered.has("small"):
		_on_small_pressed()
	
func _on_lasillan_pressed() -> void:
	GameState.symbols_discovered.append("lasillan")
	$TextureRect/Clickables/Lasillan.disabled= true
	$TextureRect/Clickables/Lasillan.focus_mode = Control.FOCUS_NONE
	$TextureRect/Clickables/Lasillan2.disabled= true
	$TextureRect/Clickables/Lasillan2.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("lasillan")

func _on_large_pressed() -> void:
	GameState.symbols_discovered.append("large")
	$TextureRect/Clickables/Large.disabled= true
	$TextureRect/Clickables/Large.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("large")

func _on_small_pressed() -> void:
	GameState.symbols_discovered.append("small")
	$TextureRect/Clickables/Small.disabled= true
	$TextureRect/Clickables/Small.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("small")
