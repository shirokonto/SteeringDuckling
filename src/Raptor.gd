extends RigidBody2D

@onready var _sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# var mob_types = $Sprite2D.sprite_frames.get_animation_names()
	# $AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_entered():
	_sprite.play("fly")

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
