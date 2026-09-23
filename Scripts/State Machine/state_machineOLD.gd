extends CharacterBody3D
#class_name StateMachine

#state machine is where we override and redirect virtual methods 
#to our current state

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

#in order to direct to virtual functions in state we need a list of states
func _ready() -> void:
	#Register all child states
	#for every child in our tree, if it extends state we assign to dictionary and current state(child) to state machine 
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_machine = self
			
	#Starts with initial state
	if initial_state:
		change_state(initial_state.name.to_lower())

func _process(delta: float) -> void:
	#updates state when we are in a state
	if current_state:
		current_state.update(delta)

#where we handle physics updates
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
	
func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state_name.to_lower())
	
	if current_state:
		current_state.enter()
