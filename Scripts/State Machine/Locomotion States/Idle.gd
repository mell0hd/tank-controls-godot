class_name IdleState
extends PlayerState


func enter():
	print(" ")
	print("Entering Idle State")
	print(player)
	
	
func _physics_process(delta: float) -> void:
	player.move_and_slide()

# Movement
func physics_update(delta: float):
	handleTurn(delta)
	if Input.is_anything_pressed() == true:
		if Input.is_action_pressed("move_forward") or Input.is_action_pressed("turn_left") or Input.is_action_pressed("turn_right") or Input.is_action_pressed("move_backward"):
			if Input.is_action_pressed("run"):
				state_machine.change_state("runstate")
			state_machine.change_state("walkstate")
		elif Input.is_action_pressed("quick_turn"):
			state_machine.change_state("quickturnstate")
	
#Player Input
func handle_input(event: InputEvent):
	pass
	
		
