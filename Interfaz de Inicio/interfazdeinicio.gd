extends Control

var c:int
var val:int

func _on_NUEVOBOTON_mouse_entered():
	$NUEVO.add_color_override("font_color", Color.white)
func _on_NUEVOBOTON_mouse_exited():
	$NUEVO.add_color_override("font_color", Color.yellow)
func _on_CARGARBOTON_mouse_entered():
	$CARGAR.add_color_override("font_color", Color.white)
func _on_CARGARBOTON_mouse_exited():
	$CARGAR.add_color_override("font_color", Color.yellow)

func _physics_process(delta):
	if c==0:
		val=GLOBAL.random(1, 1000)
	if c>=0 and c<=20:
		$luz.visible=false
	else:
		$luz.visible=true
	c+=1
	if c>=val:
		c=0


func _on_NUEVOBOTON_pressed():
	get_tree().change_scene("res://mapa/Mundo_Completo.tscn")
