extends CanvasLayer

func _physics_process(delta):
	$VBoxContainer2/pesos.text=str("$", GLOBAL.peso)
	$VBoxContainer2/dolares.text=str(GLOBAL.dolar, "USD")
	$VBoxContainer/stamina.value=GLOBAL.stamina
	$VBoxContainer/hambre.value=int(GLOBAL.hambre)
	$VBoxContainer/sed.value=int(GLOBAL.sed)
