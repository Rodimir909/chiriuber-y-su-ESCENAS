extends KinematicBody2D
 
export (Resource) var datos

onready var sprite = $Sprite
onready var humo_rueda_izq = $Humo
onready var humo_rueda_der = $Humo/Humo2
onready var cano_escape = $"Cañoescape"
onready var escape_pos = $"Cañoescape"

var velocidad = Vector2.ZERO
var deslizamiento_actual = 0.15
var rotacion_dir = 0
var angulo_giro_actual = 0.0

var is_player_on = true
signal up 
var canup = true

var vida_auto = 100

func _ready():
	if datos and datos is DatosAuto:
		$Sprite.frame = datos.Color_CTRL
		sprite.texture = datos.textura_sprite
		deslizamiento_actual = datos.deslizamiento_normal
		escape_pos.position = datos.posicion_escape
		humo_rueda_izq.position = datos.posicion_rueda_izq
		humo_rueda_der.position = datos.posicion_rueda_der
		humo_rueda_izq.scale = datos.escala_humo_ruedas
		humo_rueda_der.scale = datos.escala_humo_ruedas
	gestionar_particulas(false)
	
	if GLOBAL.teletrasportarse:
		global_position = GLOBAL.posicion_aparicion
		GLOBAL.teletrasportarse = false 
		
		

func _physics_process(delta):
	if not datos:
		return
	if not is_player_on:
		velocidad = velocidad.linear_interpolate(Vector2.ZERO, datos.friccion * delta)
		velocidad = move_and_slide(velocidad)
		return

	var input_acelerar = Input.is_action_pressed("acelerar")
	var input_frenar = Input.is_action_pressed("frenar")
	var input_giro = Input.get_action_strength("derecha") - Input.get_action_strength("izquierda")
	var input_drift = Input.is_action_pressed("mano")
	
	sprite.position = Vector2.ZERO

	var rendimiento = max(vida_auto / 100.0, 0.3)

	var velocidad_giro_actual = (datos.velocidad_giro * rendimiento) * (1.3 if input_drift else 1.0)
	rotacion_dir = lerp(rotacion_dir, input_giro * velocidad_giro_actual, datos.inercia_giro * delta)
	rotation += rotacion_dir * delta

	var direccion_frente = Vector2.RIGHT.rotated(rotation)
	var velocidad_frente = direccion_frente * velocidad.dot(direccion_frente)
	var velocidad_costado = velocidad - velocidad_frente

	if input_drift:
		velocidad = velocidad_frente + lerp(velocidad_costado, velocidad_costado * 0.98, 0.5 * delta)
	else:
		velocidad = velocidad_frente + lerp(velocidad_costado, Vector2.ZERO, 7.5 * delta)

	if input_acelerar:
		velocidad += direccion_frente * (datos.aceleracion * rendimiento) * delta
	elif input_frenar:
		velocidad -= direccion_frente * datos.frenado * delta
	else:
		velocidad = velocidad.linear_interpolate(Vector2.ZERO, datos.friccion)

	var vel_max_actual = datos.velocidad_max * rendimiento
	if velocidad.length() > vel_max_actual:
		velocidad = velocidad.clamped(vel_max_actual)

	var quemando_goma_arranque = (input_acelerar and velocidad.length() < 120.0 and vida_auto > 40)
	gestionar_particulas(input_drift or quemando_goma_arranque)

	velocidad = move_and_slide(velocidad)
	procesar_choque()

func procesar_choque():
	if get_slide_count() > 0:
		var fuerza_impacto = velocidad.length()
		if fuerza_impacto > 150.0:
			vida_auto -= int(fuerza_impacto * 0.05)
			vida_auto = max(vida_auto, 0)

func gestionar_particulas(en_drift):
	var emitiendo_humo = en_drift and velocidad.length() > 100
	if humo_rueda_izq.emitting != emitiendo_humo:
		humo_rueda_izq.emitting = emitiendo_humo
		humo_rueda_der.emitting = emitiendo_humo
		cano_escape.emitting = not emitiendo_humo

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canup = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canup = false
		
func _input(event):
	if event.is_action_pressed("accion") and canup:
		$Camera2D.current = true
		is_player_on = true
		emit_signal("up")

func _on_KinematicBody2D_down():
	$Camera2D.current = false
	is_player_on = false
