extends CanvasLayer

func _input(event):
	if event.is_action_pressed("ui_home"):
		if $Control/TextureRect/APPS.visible:
			$Control/TextureRect/APPS.visible=false
			if $Control/TextureRect/APPS/Cas:
				$Control/TextureRect/APPS/Cas.visible = false

func _on_CASINO_pressed():
	$Control/TextureRect/APPS.visible = true
	$Control/TextureRect/APPS/Cas.visible = true


func _on_NAVECITA_pressed():
	get_tree().change_scene("res://CELULAR/NAVECITAS/mundito pro.tscn")


func _on_TRAEYO_pressed():
	get_tree().change_scene("res://CELULAR/TRAEYO/TRAEYO.tscn")


func _on_MISIONES_pressed():
	get_tree().change_scene("res://CELULAR/MISIONES/MISIONES.tscn")



func _on_NERMARKET_pressed():
	get_tree().change_scene("res://CELULAR/NETMARKET/NETMARKET.tscn")


func _on_SPIFY_pressed():
	get_tree().change_scene("res://CELULAR/SPIFY/SPIFY.tscn")


func _on_DIUB_pressed():
	get_tree().change_scene("res://CELULAR/DIUB/DIUB.tscn")


func _on_WASP_pressed():
	get_tree().change_scene("res://CELULAR/WASP/WASP.tscn")


