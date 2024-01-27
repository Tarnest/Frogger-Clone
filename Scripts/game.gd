extends CanvasLayer

var scene = preload("res://Scenes/player.tscn")
var lives: int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func respawn(pos):
	await get_tree().create_timer(1.0).timeout
	var player = scene.instantiate()
	player.position = pos
	player.connect("death", Callable(self, "_on_player_death"))
	player.connect("home", Callable(self, "_on_player_home"))
	$GroundTiles.call_deferred("add_child", player)

func _on_start_button_pressed():
	$StartMenu/StartButton.visible = false


func _on_player_death(pos):
	lives -= 1
	respawn(pos)


func _on_player_home(pos):
	respawn(pos)
