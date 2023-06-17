extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var max_speed: = 8000.0
@export var wander_offset_range: = 0.3

var screen_size # Size of the game window.
var _velocity: = Vector2.ZERO
var wander_theta: = -PI / 2;
var predator_detected = false
var predator_position

const IDLE_THRESHOLD_DISTANCE: = 3.0
const WANDER_THRESHOLD_DISTANCE: = 500.0
const FLEE_THRESHOLD_DISTANCE: = 3.0

func _ready():
	screen_size = get_viewport_rect().size 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
		
	var cursor_position: Vector2 = get_viewport().get_mouse_position()
	
	if(predator_detected):
		_velocity = Steering.flee(
			_velocity,
			position,
			predator_position,
			20000.0,
			20.0
		)
		# add 
	else:
		if position.distance_to(cursor_position) > WANDER_THRESHOLD_DISTANCE:
			wander_theta += randf_range(-wander_offset_range,wander_offset_range)
			_velocity = Steering.wander(
				_velocity,
				position,
				50.0,		# wander radius
				wander_theta,
				max_speed,
				)
		elif position.distance_to(cursor_position) < IDLE_THRESHOLD_DISTANCE:	
			sprite.play("idle")
			return
		else:
			_velocity = Steering.follow(
				_velocity,
				position,
				cursor_position,
				max_speed,
				20.0
			)
	
	velocity = _velocity * delta
	if velocity.length() > 1:
		sprite.play("walking")

	move_and_slide()
	sprite.rotation = _velocity.angle() + (0.5 * PI)

func _on_area_2d_body_entered(body):
	print("predator!!!")
	predator_detected = true
	predator_position = body.position


func _on_area_2d_body_exited(body):
	print("safe...")
	predator_detected = false
