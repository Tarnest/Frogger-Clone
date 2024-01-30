extends CanvasLayer

signal camera_panned

var scene = preload("res://Scenes/player.tscn")
var lives: int = 5
var score = 0
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = get_tree().create_tween()
	await tween.tween_property($start_camera, "position", Vector2(480, 480), 3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if tween != null && !tween.is_running():
		tween = null
		camera_panned.emit()
	
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
	respawn(pos)
	removeLife()


func _on_player_home(pos):
	respawn(pos)
	update_score(40)

func lose():
	print("lost")

func update_score(amount):
	var score_text = $ScoreLabel.text.split(" ")
	score += amount
	$ScoreLabel.text = score_text[0] + " " + str(score)

func removeLife():
	lives -= 1
	var frogs = $Lives.get_children()
	if !frogs.is_empty(): # TODO: FIX THIS
		frogs.back().queue_free()
	
