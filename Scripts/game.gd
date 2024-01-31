extends CanvasLayer

signal camera_panned

var scene = preload("res://Scenes/player.tscn")
var lives: int = 5
var score = 0
var lilypads_reached = 0
var tween

var timer_seconds = 5
var initial_position_player = Vector2(480, 928)
var initial_position_timer = Vector2(864, 32)

var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = get_tree().create_tween()
	await tween.tween_property($start_camera, "position", Vector2(480, 480), 3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	$Timer.start(timer_seconds + 3)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if tween != null && !tween.is_running():
		tween = null
		camera_panned.emit()
	
	if lives <= 0:
		lose()
		
	if game_over && Input.is_action_pressed("restart_game"):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
	if lilypads_reached == 5:
		win()
	
	update_timer()


func respawn(pos):
	await get_tree().create_timer(1.0).timeout
	var player = scene.instantiate()
	player.position = pos
	player.connect("death", Callable(self, "_on_player_death"))
	player.connect("home", Callable(self, "_on_player_home"))
	player.connect("movement_points", Callable(self, "_on_player_move_up"))
	self.connect("camera_panned", Callable(player, "_on_game_camera_panned"))
	call_deferred("add_child", player)
	camera_panned.emit()
	$Timer.start(timer_seconds)


func _on_player_death(pos):
	remove_life()
	if $Player != null:
		$Player.queue_free()
	if lives > 0:
		respawn(pos)


func _on_player_home(pos):
	update_score(60)
	lilypads_reached += 1
	if lilypads_reached < 5:
		respawn(pos)


func _on_player_move_up():
	update_score(10)


func win():
	update_score(1000)
	$WinLabel.visible = true
	game_over = true
	$Timer.stop()


func lose():
	$GameOverLabel.visible = true
	game_over = true
	$Timer.stop()


func update_score(amount):
	var score_text = $ScoreLabel.text.split(" ")
	score += amount
	$ScoreLabel.text = score_text[0] + " " + str(score)


func remove_life():
	lives -= 1
	var frogs = $Lives.get_children()
	if !frogs.is_empty():
		frogs.back().queue_free()
	

func update_timer():
	var time_amount = $Timer.get_time_left()
	$Timer/Sprite2D.position.x = initial_position_timer.x - ((time_amount - timer_seconds)/timer_seconds) * 192 


func _on_timer_timeout():
	$Timer.stop()
	_on_player_death(initial_position_player)
	$Timer.start(timer_seconds)
