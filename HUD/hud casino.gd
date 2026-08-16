extends CanvasLayer

func _physics_process(delta):
	$VBoxContainer/pesos.text=str("$", GLOBAL.peso)
