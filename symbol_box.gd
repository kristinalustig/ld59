extends HFlowContainer

func _can_drop_data(position, data):
	if data.get_parent() != self:
		return true
	return false
	
func _drop_data(position, data):
	data.reparent(self)
	data.position = Vector2.ZERO
