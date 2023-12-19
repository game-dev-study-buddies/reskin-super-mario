extends CharacterBody2D


const DIRECTION_X = {
	"right": 1,
	"left": -1,
}

@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0

@onready var _animation_player = $AnimationPlayer
@onready var _animated_sprite_2d = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		_animation_player.play("jump")


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			_animation_player.play("run")
		
		if direction == DIRECTION_X.right:
			_animated_sprite_2d.flip_h = false
		else:
			_animated_sprite_2d.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animation_player.play("idle")
		if velocity.y > 0:
			_animation_player.play("jump")

	print(_animated_sprite_2d.animation)
	move_and_slide()

