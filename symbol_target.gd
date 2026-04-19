extends Panel


func _can_drop_data(_position, _data):
	return true
	
func _drop_data(_position, data):
	data.reparent(self.get_parent())
	data.global_position = Vector2(self.global_position.x + 10, self.global_position.y+10)
