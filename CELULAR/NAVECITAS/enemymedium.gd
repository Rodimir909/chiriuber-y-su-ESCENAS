extends Area2D

onready var disparomedium : int

var speed
export (PackedScene) var EXPLOSION

func _ready():
	$AnimatedSprite.play("default")
	speed = GLOBAL.random(20, 80)
	
func _physics_process(delta):
	position.y += speed * delta

func deaht_enem():
	queue_free()
	explosion_ctrl()
	GLOBAL.score+=2

func deaht_enemy():
	disparomedium+=1
	if disparomedium==2:
		queue_free()
		explosion_ctrl()
		disparomedium=0
		GLOBAL.score+=0002


	
func explosion_ctrl():
	var explosion = EXPLOSION.instance()
	explosion.global_position = $Position2D.global_position
	get_tree().call_group("level", "add_child", explosion)
		

func _on_enemymedium_body_entered(body):
	if body.is_in_group("player"):
		deaht_enem()
		body.deaht_player()
		GLOBAL.life = 0
		



func _on_enemymedium_area_entered(area):
		if area.is_in_group("shoot"):
			deaht_enemy()
			area.queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
