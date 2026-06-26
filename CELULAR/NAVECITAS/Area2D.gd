extends Area2D

onready var disparobig : int
var speed
export (PackedScene) var EXPLOSION

func _ready():

	$AnimatedSprite.play("default")
	speed = GLOBAL.random(20, 60)
	
func _physics_process(delta):
	position.y += speed * delta

func deaht_enem():
	queue_free()
	explosion_ctrl()
	GLOBAL.score+=3
	print(GLOBAL.score)

func deaht_enemy():
	disparobig+=1
	if disparobig==5:
		queue_free()
		explosion_ctrl()
		disparobig=0
		GLOBAL.score+=0003
	print(GLOBAL.score)
	
func explosion_ctrl():
	var explosion = EXPLOSION.instance()
	explosion.global_position = $Position2D.global_position
	get_tree().call_group("level", "add_child", explosion)
		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("shoot"):
		deaht_enemy()
		area.queue_free()
		



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		deaht_enem()
		body.deaht_player()
		GLOBAL.life = 0
