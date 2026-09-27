class_name IdleState
extends PlayerState


func enter():
	print(" ")
	print("Entering Idle State")

	#print(state_machine)
	
func update(delta: float):
	update_tree()	
func _physics_process(delta: float) -> void:
	handleAnimation(delta)
	player.move_and_slide()

# Movement
func physics_update(delta: float):
#specific animations
	run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
	run_val.y = lerpf(run_val.y ,0.0,blend_speed*delta)
	walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
	walk_val.y = lerpf(walk_val.y ,0.0,blend_speed*delta)
#state animatinos
	locomotion_val = lerpf(locomotion_val, 0.0, blend_speed*delta)
	crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
	update_tree()
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
	
		
