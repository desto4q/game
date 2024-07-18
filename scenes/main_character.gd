extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -700.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var last_direction = 1  # 1 for right, -1 for left

func _physics_process(delta):
	# Add the gravity.
	if (velocity.x > 1 or velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		last_direction = direction  # Update the last direction
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()

	# Flip the sprite based on the last direction
	if last_direction != 0:
		sprite_2d.flip_h = last_direction < 0
