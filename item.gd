extends Control

@export var item_id: String
@export var spritesheet_index: int

func _get_drag_data(position):
	if mouse_filter == Control.MOUSE_FILTER_IGNORE:
		return null
	set_drag_preview(self.duplicate())
	if not self.get_child(1):
		add_child(GameData.s_sym_up)
	GameData.s_sym_up.play()
	return self

func on_creation(id: String, ind: int):
	item_id = id
	spritesheet_index = ind-1
	var t = AtlasTexture.new()
	t.atlas = GameData.symbol_sprites
	var region_x = spritesheet_index % 8
	var region_y = spritesheet_index / 8
	t.region = Rect2(region_x*64, region_y*64, 64, 64)
	$SymbolPanel/SymbolImg.texture = t
	$SymbolPanel/SymbolImg.scale = Vector2(.9, .9)
	
