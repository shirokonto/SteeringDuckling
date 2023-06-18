extends Node2D

@export var predator_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$PredatorTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_predator_timer_timeout():
	var predator = predator_scene.instantiate()
	
	var predator_spawn_location = get_node("PredatorPath/PredatorSpawnLocation")
	predator_spawn_location.progress_ratio = randf()
	
	var direction = predator_spawn_location.rotation + PI / 2
	
	predator.position = predator_spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	predator.rotation = direction

	var velocity = Vector2(randf_range(100.0, 150.0), 0.0)
	predator.linear_velocity = velocity.rotated(direction)

	add_child(predator)
