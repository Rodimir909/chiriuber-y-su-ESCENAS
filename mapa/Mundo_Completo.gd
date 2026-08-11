extends Node2D

signal taler

func _ready():
	if GLOBAL.pos == "casino":
		$KinematicBody2D.position = Vector2(9200,8000)
		$Auto.position = Vector2(9300,8000)
		GLOBAL.pos = ""
	elif GLOBAL.pos == "taller":
		emit_signal("taler")
		$Auto.position = Vector2(10931,2630)
		$Auto.rotate(deg2rad(90))
		GLOBAL.pos = ""

func _on_puerta_body_entered(body):
	
	if body.is_in_group("player"):
		GLOBAL.pos = "casino"
		get_tree().change_scene("res://CASINO FISICO INTERFAZ/casino fisico.tscn")

func _on_KinematicBody2D_down():

	$KinematicBody2D.position = $Auto.position


func _on_Puerta2_body_entered(body):
	
	if body.is_in_group("car"):
		GLOBAL.pos = "taller"
		get_tree().change_scene("res://TALLER/taller_interfaz.tscn")
