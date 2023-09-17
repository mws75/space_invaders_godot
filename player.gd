extends Area2D
signal hit


@export var Bullet : PackedScene
@export var speed = 600
var screen_size

var BULLET_COOL_DOWN_PERIOD = 60
var EXTREME_COOL_DOWN_PERIOD = 30
var BULLET_COOL_DOWN_TIME = 0 
var BULLET_READY_TO_SHOOT = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.animation = "fly_right"
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.animation = "fly_left"
		velocity.x += -1
	if Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.animation = "fly"
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		$AnimatedSprite2D.animation = "fly"
		velocity.y += -1
	if Input.is_action_pressed("shoot"):
		if BULLET_READY_TO_SHOOT == true: 
			shoot()
		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed 
		$AnimatedSprite2D.play()
	else: 
		$AnimatedSprite2D.animation = "fly"
		$AnimatedSprite2D.stop()
		
	
	position += velocity * delta 
	var width = 0
	var height = 0
	# Clamp position
	position.x = clamp(position.x, 75, screen_size.x - 75)
	position.y = clamp(position.y, 600, screen_size.y - 75)
	cool_down()
	
	

func shoot():
	BULLET_READY_TO_SHOOT = false
	BULLET_COOL_DOWN_TIME = BULLET_COOL_DOWN_PERIOD
	var bullet = Bullet.instantiate()
	owner.add_child(bullet)
	bullet.transform = $Muzzle.global_transform
	
func cool_down():
	if BULLET_READY_TO_SHOOT == false: 
		BULLET_COOL_DOWN_TIME -= 1 
	if BULLET_COOL_DOWN_TIME == 0: 
		BULLET_READY_TO_SHOOT = true
	
	
			
func start(pos):
	position = pos
	show()


func _on_area_entered(area):
	#pass
	# game will end on hit.emit()
	hit.emit()
