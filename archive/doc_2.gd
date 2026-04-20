extends Control

@export var archive_id: int = 2
@export var archive_title: String = "Chart.png"

func _ready():
	if GameState.symbols_discovered.has("time"):
		_on_time_pressed()
	if GameState.symbols_discovered.has("type"):
		_on_type_pressed()
	if GameState.symbols_discovered.has("past"):
		_on_past_pressed()
	if GameState.symbols_discovered.has("to"):
		_on_to_pressed()
	if GameState.symbols_discovered.has("future"):
		_on_future_pressed()
	if GameState.symbols_discovered.has("recent"):
		_on_recent_pressed()
	if GameState.symbols_discovered.has("present"):
		_on_present_pressed()
	if GameState.symbols_discovered.has("soon"):
		_on_soon_pressed()

func _on_time_pressed() -> void:
	GameState.symbols_discovered.append("time")
	$TextureRect/Clickables/Time.disabled= true
	$TextureRect/Clickables/Time.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("time")

func _on_type_pressed() -> void:
	GameState.symbols_discovered.append("type")
	$TextureRect/Clickables/Type.disabled= true
	$TextureRect/Clickables/Type.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("type")

func _on_past_pressed() -> void:
	GameState.symbols_discovered.append("past")
	$TextureRect/Clickables/Past.disabled= true
	$TextureRect/Clickables/Past.focus_mode = Control.FOCUS_NONE
	$TextureRect/Clickables/Past2.disabled= true
	$TextureRect/Clickables/Past2.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("past")

func _on_to_pressed() -> void:
	GameState.symbols_discovered.append("to")
	$TextureRect/Clickables/To.disabled= true
	$TextureRect/Clickables/To.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("to")

func _on_future_pressed() -> void:
	GameState.symbols_discovered.append("future")
	$TextureRect/Clickables/Future.disabled= true
	$TextureRect/Clickables/Future.focus_mode = Control.FOCUS_NONE
	$TextureRect/Clickables/Future2.disabled= true
	$TextureRect/Clickables/Future2.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("future")

func _on_recent_pressed() -> void:
	GameState.symbols_discovered.append("recent")
	$TextureRect/Clickables/Recent.disabled= true
	$TextureRect/Clickables/Recent.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("recent")

func _on_present_pressed() -> void:
	GameState.symbols_discovered.append("present")
	$TextureRect/Clickables/Present.disabled= true
	$TextureRect/Clickables/Present.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("present")

func _on_soon_pressed() -> void:
	GameState.symbols_discovered.append("soon")
	$TextureRect/Clickables/Soon.disabled= true
	$TextureRect/Clickables/Soon.focus_mode = Control.FOCUS_NONE
	GameData.symbol_clicked.emit("soon")
