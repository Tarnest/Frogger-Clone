extends CanvasLayer

var scene = preload("res://Scenes/player.tscn")
var lives: int = 5
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if lives <= 0:
		lose()


func respawn(pos):
	await get_tree().create_timer(1.0).timeout
	var player = scene.instantiate()
	player.position = pos
	player.connect("death", Callable(self, "_on_player_death"))
	player.connect("home", Callable(self, "_on_player_home"))
	call_deferred("add_child", player)


func _on_player_death(pos):
	lives -= 1
	updateScore(10)
	respawn(pos)
	removeLife()


func _on_player_home(pos):
	respawn(pos)

func lose():
	print("lost")

func updateScore(amount):
	var score_text = $ScoreLabel.text.split(" ")
	score += amount
	$ScoreLabel.text = score_text[0] + " " + str(score)

func removeLife():
	var frogs = $Lives.get_children()
	if frogs != null: # TODO: FIX THIS
		frogs.back().queue_free()
	
