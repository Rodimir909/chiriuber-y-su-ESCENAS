extends Area2D

onready var player: KinematicBody2D = get_tree().get_nodes_in_group("player")[0]

const SPEED=810

func _ready():
	$AnimatedSprite.play("default")
	GLOBAL.time=false


func _physics_process(delta):
	position.y -= SPEED * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()




func _on_disparo_area_entered(area):
	if area.is_in_group("enemy"):
		queue_free()
	if area.is_in_group("enemymedium"):
		queue_free()
	if area.is_in_group("enemybig"):
		queue_free()
			
