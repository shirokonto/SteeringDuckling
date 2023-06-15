extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var max_speed: = 5000.0  

var screen_size # Size of the game window.
var _velocity = Vector2.ZERO

const DISTANCE_THRESHOLD: = 3.0

func _ready():
	screen_size = get_viewport_rect().size 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var coursor_position: Vector2 = get_viewport().get_mouse_position()
	
	if global_position.distance_to(coursor_position) < DISTANCE_THRESHOLD:
		return
		
	_velocity = Steering.follow(
		_velocity,
		global_position,
		coursor_position,
		max_speed
	)
	velocity = _velocity * delta

	if velocity.length() > 0:
		sprite.play("walking")
	else:
		sprite.play("idle")
	
	move_and_slide()
	sprite.rotation = _velocity.angle() + (0.5 * PI)
