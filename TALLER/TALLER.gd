extends Control

signal taller
signal outaller

var precio :  int


func _physics_process(delta):
	if precio>0:
		$VBoxContainer2/Button.text = "Precio" + "\n" + str(precio)
	else:
		$VBoxContainer2/Button.text = "El auto no necesita reparse"
	precio_ctrl()

func _input(event):
	if event.is_action_pressed("accion"):
		get_tree().change_scene("res://mapa.tscn")
		emit_signal("outaller")
		

func _ready():
	emit_signal("taller")

func precio_ctrl():
	var roto = $Auto.vida_auto
	precio=(100-$Auto.vida_auto)*10
		
  

