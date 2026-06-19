extends Control

signal taller
signal outaller

func _input(event):
	if event.is_action_pressed("accion"):
		get_tree().change_scene("res://mapa.tscn")
		emit_signal("outaller")
		

func _ready():
	emit_signal("taller")

