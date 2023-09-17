extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var mod_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mod_types[randi() % mod_types.size()])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(0, 150)
	position += velocity * delta 


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() 
	


func _on_area_entered(area):
	print("enemy hit")
