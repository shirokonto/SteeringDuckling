extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var max_speed: = 8000.0
@export var wander_offset_range: = 0.3

var screen_size # Size of the game window.
var _velocity: = Vector2.ZERO
var wander_theta: = -PI / 2;

const IDLE_THRESHOLD_DISTANCE: = 3.0
const WANDER_THRESHOLD_DISTANCE: = 500.0

func _ready():
	screen_size = get_viewport_rect().size 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if global_position.x < 0:
		global_position.x = screen_size.x
	if global_position.x > screen_size.x:
		global_position.x = 0
		
	if global_position.y < 0: 
		global_position.y = screen_size.y
	if global_position.y > screen_size.y:
		global_position.y = 0
	var coursor_position: Vector2 = get_viewport().get_mouse_position()
	
	if global_position.distance_to(coursor_position) > WANDER_THRESHOLD_DISTANCE:
		wander_theta += randf_range(-wander_offset_range,wander_offset_range)
		_velocity = Steering.wander(
			_velocity,
			global_position,
			50.0,		# wander radius
			wander_theta,
			max_speed,
			)
	elif global_position.distance_to(coursor_position) < IDLE_THRESHOLD_DISTANCE:
		sprite.play("idle")
		return
	else:
		_velocity = Steering.follow(
			_velocity,
			global_position,
			coursor_position,
			max_speed,
			20.0
		)
		
	
	velocity = _velocity * delta
	if velocity.length() > 1:
		sprite.play("walking")

	move_and_slide()
	sprite.rotation = _velocity.angle() + (0.5 * PI)
