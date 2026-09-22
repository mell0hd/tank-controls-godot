extends PlayerState
class_name idle



func Enter():
	animation_player = $"../../Model/AnimationPlayer"
	animation_player.play("mixamo_com")

#handles exiting states	
func Exit():
	pass
	
#tied to visual framerate	
func Update(_delta: float):
	pass

#updates in ticks physics	
func Physics_Update(_delta: float):
	pass


func _on_player_walk() -> void:
	Transitioned.emit(self,"Walking")
