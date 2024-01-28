extends CharacterBody2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
@export var dir = "right"
@export var speed = 100
@export var car_type = "car1"
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	if dir == "right":
		direction = Vector2.RIGHT
	elif dir == "left":
		direction = Vector2.LEFT
		rotation = deg_to_rad(180)
	
	if self.is_in_group("Car"):
		$AnimatedSprite2D.play(car_type)


func _physics_process(delta):
	velocity = direction * speed
	
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	if dir == "right":
		position.x = position.x - 1350
	elif dir == "left":
		position.x = position.x + 1350
