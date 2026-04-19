extends Control

@export var item_id: String
@export var spritesheet_index: int

func _get_drag_data(position):
	set_drag_preview(self.duplicate())
	return self

func on_creation(id: String, ind: int):
	item_id = id
	spritesheet_index = ind
	
