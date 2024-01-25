extends CharacterBody2D

@export var speed = 4
const TILE_SIZE = 64

var tween
var active = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(_delta):
	# Add the gravity.
	# if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction = Input.get_axis("ui_left", "ui_right")
	# if direction:
	# 	velocity.x = direction * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction = Vector2.ZERO
	if (tween == null || !tween.is_running()) && active:
		if Input.is_action_pressed("move_up"):
			move(Vector2.UP)
		if Input.is_action_pressed("move_down"):
			move(Vector2.DOWN)
		if Input.is_action_pressed("move_left"):
			move(Vector2.LEFT)
		if Input.is_action_pressed("move_right"):
			move(Vector2.RIGHT)

func move(dir):
	var end_position = position + dir * TILE_SIZE
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_position, 1.0 / speed)
	tween.play()


func _on_start_button_pressed():
	active = true
