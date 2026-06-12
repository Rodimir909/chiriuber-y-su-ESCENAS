extends KinematicBody2D


onready var  SPEED = 100 #velociad de la nave
onready var motion = Vector2.ZERO #para que se mueva en vector x y
onready var screensize = get_viewport_rect().size #saber el tamaño de la pantalla



func _ready():
	$AnimatedSprite.play("IDLE")
	
func _physics_process(delta):
	motion_ctrl()
	motion = move_and_collide(motion  * delta)

func get_axis()->Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	if axis.x==1 and axis.y==1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=-45
	elif axis.x==-1 and axis.y==1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=-135
	elif axis.x==1 and axis.y==-1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=-315
	elif axis.x==-1 and axis.y==-1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=-225
	elif axis.x==1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=265
	elif axis.x==-1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=90
	elif axis.y==1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=0
	elif axis.y==-1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=180
	else:
		$AnimatedSprite.play("IDLE")
	return axis
	
func motion_ctrl():
	if get_axis() == Vector2.ZERO:
		motion = Vector2.ZERO
	else:
		motion = get_axis().normalized()*SPEED
	position.x = clamp(position.x, 0+8, screensize.x-8)
	position.y = clamp(position.y, 0+12, screensize.y-10)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		$AnimatedSprite.speed_scale=2
		SPEED=200
	if event.is_action_released("ui_accept"):
		SPEED=100
		$AnimatedSprite.speed_scale=1

									   
