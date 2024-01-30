extends CharacterBody2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var dir = "right"
@export var speed = 100
@export var car_type = "car1"
@export var log_type = "log1"
@export var turtle_type = "turtle1"

var direction = Vector2.ZERO
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var game = get_tree().get_root().get_node("Game")
	game.connect("camera_panned", Callable(self, "_on_camera_pan"))
	
	if dir == "right":
		direction = Vector2.RIGHT
	elif dir == "left":
		direction = Vector2.LEFT
		rotation = deg_to_rad(180)
	
	if self.is_in_group("Car"):
		$AnimatedSprite2D.play(car_type)
	if self.is_in_group("Log"):
		change_log(log_type)
	if self.is_in_group("Turtles"):
		change_turtle(turtle_type)


func _physics_process(delta):
	velocity = direction * speed
	
	if active:
		move_and_slide()


func change_log(type):
	$AnimatedSprite2D.play(type)
	match type:
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


func change_turtle(type):
	$AnimatedSprite2D.play(type)
	match type:
		"turtle1":
			$CollisionShape2D.shape.size.x = 64
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-32, -30, 64, 60))
		"turtle2":
			$CollisionShape2D.shape.size.x = 128
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-64, -30, 128, 60))
		"turtle3":
			$CollisionShape2D.shape.size.x = 192
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-96, -30, 192, 60))
		"turtle4":
			$CollisionShape2D.shape.size.x = 256
			$VisibleOnScreenNotifier2D.set_rect(Rect2(-128, -30, 256, 60))


func _on_camera_pan():
	active = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	if dir == "right":
		position.x = position.x - 1350
	elif dir == "left":
		position.x = position.x + 1350
