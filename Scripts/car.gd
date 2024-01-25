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


func _physics_process(_delta):
	velocity = direction * speed
	
	move_and_slide()
