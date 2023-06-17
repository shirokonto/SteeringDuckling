extends Node2D

@export var raptor_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$RaptorTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_raptor_timer_timeout():
	var raptor = raptor_scene.instantiate()
	
	var raptor_spawn_location = get_node("RaptorPath/RaptorSpawnLocation")
	raptor_spawn_location.progress_ratio = randf()
	
	var direction = raptor_spawn_location.rotation + PI / 2
	
	raptor.position = raptor_spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	raptor.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	raptor.linear_velocity = velocity.rotated(direction)

	add_child(raptor)

	
