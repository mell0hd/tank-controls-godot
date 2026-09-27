class_name RunState
extends PlayerState

func enter():
	print(" ")
	print("entered run state")
	

#Frame Logic
func update(delta: float):
	update_tree()

# Movement
func physics_update(delta: float):
	#specific animations
	run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
	run_val.y = lerpf(run_val.y ,1.0,blend_speed*delta)
	walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
	walk_val.y = lerpf(walk_val.y ,1.0,blend_speed*delta)
#state animatinos
	locomotion_val = lerpf(locomotion_val, 1.0, blend_speed*delta)
	crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
	handleTurn(delta)
	if Input.is_action_pressed("run"):
		handleRun(delta)
		
	else:
		state_machine.change_state("idlestate")
	
	if is_quick_turning:
		state_machine.change_state("quickturnstate")
	player.move_and_slide()
#Player Input
func handle_input(event: InputEvent):
	pass
