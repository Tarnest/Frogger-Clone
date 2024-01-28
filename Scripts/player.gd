extends CharacterBody2D

signal death(pos)
signal home(pos)

@export var speed = 4
const TILE_SIZE = 64

var tween
var start_position

var platform: CharacterBody2D = null
var platform_velocity
var on_water = false
var on_log = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	start_position = position


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
	
	if !$AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("idle")
	
	if (tween == null || !tween.is_running()):
		if Input.is_action_pressed("move_up"):
			rotation_degrees = 0
			move(Vector2.UP)
		if Input.is_action_pressed("move_down"):
			rotation_degrees = 180
			move(Vector2.DOWN)
		if Input.is_action_pressed("move_left"):
			rotation_degrees = 270
			move(Vector2.LEFT)
		if Input.is_action_pressed("move_right"):
			rotation_degrees = 90
			move(Vector2.RIGHT)
	
	if on_water && !on_log:
		die()
	
	if platform != null:
		velocity = platform_velocity
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func move(dir):
	var end_position = position + dir * TILE_SIZE
	
	$AnimatedSprite2D.play("hop")
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_position, 1.0 / speed)
	tween.play()


func die():
	queue_free()
	death.emit(start_position)


func reach_home():
	queue_free()
	home.emit(start_position)


func _on_area_2d_body_entered(body):
	if body.is_in_group("Car"):
		queue_free()
		emit_signal("death", start_position)
	if body.is_in_group("Log"):
		on_log = true
		platform = body
		platform_velocity = body.velocity
		print("Enter Log")
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("Log"):
		print("Leave Log")
		if platform == body:
			on_log = false
			platform = null


func _on_area_2d_area_entered(area):
	if area.name == "Home":
		die()
	elif area.is_in_group("Home"):
		if !area.is_visible():
			area.visible = true
			reach_home()
		else:
			die()
	if area.is_in_group("Water"):
		on_water = true
		print("Enter River")
	


func _on_area_2d_area_exited(area):
	if area.is_in_group("Water"):
		on_water = false
		print("Leave River")


func _on_visible_on_screen_notifier_2d_screen_exited():
	die()


func wait(num):
	await get_tree().create_timer(num).timeout
