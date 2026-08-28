extends KinematicBody2D


onready var  SPEED = 100 #velociad de la nave
onready var motion = Vector2.ZERO #para que se mueva en vector x y
onready var screensize = get_viewport_rect().size #saber el tamaño de la pantalla



var is_on_car = false
var can_down = false
signal down

func _ready():
	$AnimatedSprite.play("IDLE")
	
func posicion():
	GLOBAL.posiccion=self.global_position + Vector2(0, 25)
func ca():
	GLOBAL.daa=self.global_position + Vector2(0, 25)
func _physics_process(delta):
	if not is_on_car:
		motion_ctrl()
		motion = move_and_collide(motion* delta)
	else:
		pass
	if SPEED==200 and GLOBAL.stamina>0 and is_on_car==false:
		GLOBAL.stamina-=1
		GLOBAL.sed-=0.001
		GLOBAL.hambre-=0.0005
	elif SPEED==100 and GLOBAL.stamina<100:
		GLOBAL.stamina+=0.3
	elif GLOBAL.stamina<=0 and is_on_car==false:
		SPEED=101
		$AnimatedSprite.speed_scale=1
	GLOBAL.sed-=0.0001
	GLOBAL.hambre-=0.0001
	
func get_axis()->Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	if axis.x==1 and axis.y==1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=-45
	elif axis.x==-1 and axis.y==1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=45
	elif axis.x==1 and axis.y==-1:
		$AnimatedSprite.play("CAMINAR")
		$AnimatedSprite.rotation_degrees=-135
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

	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if GLOBAL.stamina>1 and is_on_car==false:
			$AnimatedSprite.speed_scale=2
			SPEED=200
	if event.is_action_released("ui_accept"):
		SPEED=100
		$AnimatedSprite.speed_scale=1
	if event.is_action_pressed("accion") :
		bajar()
	if event.is_action_pressed("celu"):
		if not $Control.visible:
			$Control.visible = true
		else:
			$Control.visible = false
func bajar():
	if is_on_car:
		$Camera2D.current = true
		is_on_car = false
		$AnimatedSprite.visible = true
		$CollisionShape2D.disabled = false
		can_down = false
		emit_signal("down")


func _on_Auto_up():
	$Camera2D.current = false
	$CollisionShape2D.disabled = true
	$AnimatedSprite.visible = false
	$Timer.start()



func _on_Timer_timeout():
	is_on_car=true



