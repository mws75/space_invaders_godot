extends Node

@export var enemy_scene: PackedScene
var score

var CREATE_ENEMIES = true

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$ModTimer.stop()
	print("game over")
	
func new_game():
	score = 0 
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mod_timer_timeout():
	print("CREATE_ENEMIES: ", CREATE_ENEMIES)
	if CREATE_ENEMIES == true:		
		var base_enemy = enemy_scene.instantiate()
		var base_enemy_spawn_location = get_node("ModPath/ModSpawnLocation")
		base_enemy_spawn_location.progress_ratio = randf()
		
		#set the mob's position to a random location 
		base_enemy.position = base_enemy_spawn_location.position

		# spawn the enemy by adding it to the main screen 
		add_child(base_enemy)
		

func _on_score_timer_timeout():
	score += 1
	
	


func _on_start_timer_timeout():
	$ModTimer.start()
	$ScoreTimer.start()
	$ModIncreaseTimer.start()


func _on_mod_timer_boss_time():
	CREATE_ENEMIES = false
	print("no more creating enemies")
