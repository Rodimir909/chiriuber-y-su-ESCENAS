extends Node2D



func _on_Area2D_body_entered(body):
	if body.is_in_group("car"):
		GLOBAL.enviaje=false
		GLOBAL.emit_signal("fin")
		visible=false
		GLOBAL.acepta=false
