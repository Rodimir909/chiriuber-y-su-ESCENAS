extends Area2D

var speed
export (PackedScene) var EXPLOSION

func _ready():
	$AnimatedSprite.play("default")
	speed = GLOBAL.random(40, 100)
	
func _physics_process(delta):
	position.y += speed * delta

func deaht_enemy():
	queue_free()
	explosion_ctrl()
	GLOBAL.score+=0001
	
func explosion_ctrl():
	var explosion = EXPLOSION.instance()
	explosion.global_position = $Position2D.global_position
	get_tree().call_group("level", "add_child", explosion)
	


func _on_enemysmall_body_entered(body):
	if body.is_in_group("player"):
		deaht_enemy()
		body.deaht_player()
		GLOBAL.life = 0



func _on_enemysmall_area_entered(area):
	if area.is_in_group("shoot"):
		deaht_enemy()
		area.queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
