extends Control

func _input(event):
	if event.is_action_pressed("ui_home"):
		get_tree().change_scene("res://CELULAR/CELULAR.tscn")
