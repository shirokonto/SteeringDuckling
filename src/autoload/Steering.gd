extends Node

const DEFAULT_MASS: = 2.0
const DEFAULT_MAX_SPEED: = 2.0
const DEFAULT_WANDER_RADIUS: = 50.0
const DEFAULT_WANDER_THETA: = PI / 2

static func follow(
		velocity: Vector2,
		global_position: Vector2,
		target_position: Vector2,
		max_speed: = DEFAULT_MAX_SPEED,
		mass: = DEFAULT_MASS
	) -> Vector2:
	var desired_velocity: = (target_position - global_position).normalized() * max_speed
	var steering: = ((desired_velocity - velocity) / mass)
	return velocity + steering 

static func flee(
		velocity: Vector2,
		global_position: Vector2,
		target_position: Vector2,
		max_speed: = DEFAULT_MAX_SPEED,
		mass: = DEFAULT_MASS
	) -> Vector2:
	var desired_velocity: = (global_position - target_position).normalized() * max_speed
	var steering: = ((desired_velocity - velocity) / mass)
	return velocity + steering 
	
static func wander(
		velocity: Vector2,
		global_position: Vector2,
		wander_radius: = DEFAULT_WANDER_RADIUS,
		wander_theta = DEFAULT_WANDER_THETA,
		max_speed: = DEFAULT_MAX_SPEED,
		mass: = DEFAULT_MASS
	) -> Vector2:
	var wander_point = velocity.normalized() * 1000 + global_position 
	var theta = wander_theta + velocity.angle()
	var x = wander_radius * cos(wander_theta)
	var y = wander_radius * sin(wander_theta)
	wander_point = wander_point + Vector2(x, y)
	var steering = ((wander_point - global_position).normalized() * max_speed) / mass
	return steering
	
