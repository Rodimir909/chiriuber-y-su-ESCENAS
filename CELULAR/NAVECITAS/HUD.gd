extends CanvasLayer



func _ready():
	GLOBAL.score=0
	
func _physics_process(delta):
	$MarginContainer/HBoxContainer/scores/varscore.text = str(GLOBAL.score)
	$MarginContainer/HBoxContainer/vidas/vidascore.text = str(GLOBAL.life)
	
func _input(event):
	if event.is_action_pressed("ui_home"):
		$VBoxContainer.visible=true
		get_tree().paused = true


func _on_navecita_tree_exited():
	$gameover.visible = true


func _on_reiniciar_pressed():
	get_tree().reload_current_scene()


func _on_salir_pressed():
	get_tree().change_scene("res://CELULAR/CELULAR.tscn")





func _on_volver_pressed():
	get_tree().paused=false
	$VBoxContainer.visible=false






func _on_salircelu_pressed():
	get_tree().paused=false
	get_tree().change_scene("res://CELULAR/CELULAR.tscn")
