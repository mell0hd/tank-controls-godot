class_name WalkState
extends PlayerState




# Initilization
func enter():
	print(" ")
	print("entered walk state")
	

func update(delta: float):
	update_tree()
	
# Movement
func _physics_process(delta):
	#specific animations
	run_val.x = lerpf(run_val.x ,0.0,blend_speed*delta)
	run_val.y = lerpf(run_val.y ,1.0,blend_speed*delta)
	walk_val.x = lerpf(walk_val.x ,0.0,blend_speed*delta)
	walk_val.y = lerpf(walk_val.y ,1.0,blend_speed*delta)
#state animatinos
	locomotion_val = lerpf(locomotion_val, -1.0, blend_speed*delta)
	crouching_val = lerpf(crouching_val ,0.0,blend_speed*delta)
	
	handleWalk(delta)
	handleTurn(delta)
	
	
	player.move_and_slide()

#Player Input
func handle_input(event: InputEvent):
	
	
# State Transitions
	if Input.is_action_pressed("quick_turn"):
		state_machine.change_state("quickturnstate")
		
	elif Input.is_action_pressed("run"):
		state_machine.change_state("runstate")
				
	elif Input.is_anything_pressed() == false:
			state_machine.change_state("idlestate")
