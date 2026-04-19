extends BoxContainer

func _can_drop_data(position, data):
	return true
	
func _drop_data(position, data):
	data.reparent(self.get_parent())
	data.global_position = self.global_position
