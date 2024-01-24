extends RigidBody2D

var speed = 300
var velocity

@export var direction = "right"

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == "right":
		velocity = Vector2.RIGHT
	elif direction == "left":
		velocity = Vector2.LEFT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
