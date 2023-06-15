extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var max_speed: = 8000.0  

var screen_size # Size of the game window.
var _velocity: = Vector2.ZERO
var wander_theta: = -PI / 2;

const DISTANCE_THRESHOLD: = 3.0

func _ready():
	screen_size = get_viewport_rect().size 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var coursor_position: Vector2 = get_viewport().get_mouse_position()
	
	if global_position.distance_to(coursor_position) < DISTANCE_THRESHOLD:
		return
		
#	_velocity = Steering.flee(
#		_velocity,
#		global_position,
#		coursor_position,
#		max_speed,
#		20.0
#	)
	
	_velocity = Steering.wander(
		_velocity,
		global_position,
		50.0,		# wander radius
		wander_theta,
		max_speed,
		20.0
	) 
	
	velocity = _velocity * delta
	if velocity.length() > 1:
		sprite.play("walking")
	elif velocity.length() < 1:
		# print("it should have stopped >:(")
		sprite.stop()
		sprite.animation = "idle"
	
	move_and_slide()
	sprite.rotation = _velocity.angle() + (0.5 * PI)
