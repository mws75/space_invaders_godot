extends Area2D

var speed = 1300

func _physics_process(delta):
	position -= transform.y * speed * delta
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_area_entered(area):
	if area.is_in_group("mods"):
		area.queue_free()
	queue_free()
	
	print("bullet hit something")
