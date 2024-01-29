extends CharacterBody2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
@export var dir = "right"
@export var speed = 100
@export var car_type = "car1"
@export var log_type = "log1"
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
	if self.is_in_group("Log"):
		change_log(log_type)


func change_log(log_type):
	$AnimatedSprite2D.play(log_type)
	match log_type:
		"log1":
			$CollisionShape2D.shape.size.x = 120
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-60, -26, 120, 52))
		"log2":
			$CollisionShape2D.shape.size.x = 180
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-90, -26, 180, 52))
		"log3":
			$CollisionShape2D.shape.size.x = 240
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-120, -26, 240, 52))
		"log4":
			$CollisionShape2D.shape.size.x = 300
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-150, -26, 300, 52))
		"log5":
			$CollisionShape2D.shape.size.x = 360
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-180, -26, 360, 52))


func _physics_process(delta):
	velocity = direction * speed
	
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	if dir == "right":
		position.x = position.x - 1350
	elif dir == "left":
		position.x = position.x + 1350
