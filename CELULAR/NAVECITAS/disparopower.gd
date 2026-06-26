extends Area2D

var speed

func _ready():
	$AnimatedSprite.play("default")
	speed = GLOBAL.random(40, 100)
	
func _physics_process(delta):
	position.y += speed * delta



func _on_disparopower_body_entered(body):
	if GLOBAL.life > 0:
		if body.is_in_group("player"):
			GLOBAL.sad=0.05
			body.pu_time()
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
