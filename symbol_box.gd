extends BoxContainer

func _can_drop_data(position, data):
	return true
	
func _drop_data(position, data):
	data.reparent(self)
	data.position = Vector2.ZERO
	data.scale = Vector2(.225, .225)
