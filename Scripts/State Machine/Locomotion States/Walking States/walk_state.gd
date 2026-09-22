extends PlayerState
class_name WalkState



# Initilization
func enter():
	print(" ")
	print("entered walk state")
	
# Movement
func _physics_process(delta):
	handleWalk(delta)
	
	
	move_and_slide()

#Player Input
func handle_input(event: InputEvent):
	if Input.is_action_pressed("run"):
		state_machine.change_state("runstate")
	
	if is_quick_turning:
		state_machine.change_state("quickturnstate")
	if Input.is_anything_pressed() == false:
		state_machine.change_state("idlestate")
