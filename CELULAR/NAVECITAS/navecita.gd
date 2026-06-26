extends KinematicBody2D

export(PackedScene) var SHOOT
export (PackedScene) var EXPLOSION

const SPEED = 300 #velociad de la nave
onready var motion = Vector2.ZERO #para que se mueva en vector x y
onready var screensize = get_viewport_rect().size #saber el tamaño de la pantalla


#Funciones
func _ready():
	$AnimatedSprite.play("default")
	GLOBAL.life=3
	GLOBAL.time=true
	GLOBAL.sad=0.3


func get_axis()->Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis
	
func motion_ctrl():
	if get_axis() == Vector2.ZERO:
		motion = Vector2.ZERO
	else:
		motion = get_axis().normalized()*SPEED
	position.x = clamp(position.x, 0+8, screensize.x-8)
	position.y = clamp(position.y, 0+12, screensize.y-10)
	
func deaht_player():
	queue_free()
	explosion_ctrl()

 
func explosion_ctrl():
	var explosion = EXPLOSION.instance()
	explosion.global_position = $Position2D2.global_position
	get_tree().call_group("level", "add_child", explosion)

func _input(event):
	if event.is_action_pressed("ui_select") and GLOBAL.time==true:
		$Timersad.wait_time = GLOBAL.sad
		$Timersad.start()
		shoot_ctrl()

func _physics_process(delta):
	motion_ctrl()
	motion = move_and_collide(motion  * delta)
	if GLOBAL.life <= 0:
		deaht_player()

func shoot_ctrl():
	var shoot = SHOOT.instance()
	shoot.global_position = $Position2D.global_position
	get_tree().call_group("level", "add_child",shoot)
	
func _on_Timersad_timeout():
	GLOBAL.time=true

func pu_time():
	$Timerdisparo.wait_time=3
	$Timerdisparo.start()

func _on_Timerdisparo_timeout():
	GLOBAL.sad = 0.3
