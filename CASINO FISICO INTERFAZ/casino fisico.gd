extends Control

export (PackedScene) var JUGADOR



func _ready():
	GLOBAL.connect("salir", self, "sal")
	$spawn.position=Vector2(GLOBAL.daa)
	var jugador = JUGADOR.instance()
	jugador.position = $spawn.position
	jugador.desactivar_interfaz()
	add_child(jugador)

func _on_blackjack_body_entered(body):
	if body.is_in_group("player"):
		body.ca()
		$spawn.global_position=Vector2(GLOBAL.daa)
		GLOBAL.emit_signal("guardartelefono")
		$Control.visible=true
		$Control/blackjack.visible=true
		
func sal():
	$Control.visible=false
	GLOBAL.no=false
	if $Control/blackjack.visible==true:
		$Control/blackjack.visible=false
	elif $Control/ruleta.visible==true:
		$Control/ruleta.visible=false


func _on_ruleta_body_entered(body):
	if body.is_in_group("player"):
		body.ca()
		$spawn.global_position=Vector2(GLOBAL.daa)
		GLOBAL.emit_signal("guardartelefono")
		$Control.visible=true
		$Control/ruleta.visible=true


func _on_SALIR_body_entered(body):
	if body.is_in_group("player"):
		GLOBAL.daa=Vector2(478,525)
		GLOBAL.emit_signal("esconcasino")
