extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
@export var dir = "right"
@export var speed = 100
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	if dir == "right":
		direction = Vector2.RIGHT
	elif dir == "left":
		direction = Vector2.LEFT


func _physics_process(delta):
	# Add the gravity.
	# if not is_on_floor():
	# 	velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	
	velocity = direction * speed
	
	move_and_slide()
