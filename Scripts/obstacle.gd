extends CharacterBody2D

signal PlayerCollision
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
	velocity = direction * speed
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var body = collision.get_collider()
		if body.name == "Player":
			emit_signal("PlayerCollision")


func _on_visible_on_screen_notifier_2d_screen_exited():
	if dir == "right":
		position.x = position.x - 1500
	elif dir == "left":
		position.x = position.x + 1500
