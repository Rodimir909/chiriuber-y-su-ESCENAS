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

var is_player_on = false

func _ready():
	if datos and datos is DatosAuto:
		sprite.texture = datos.textura_sprite
		deslizamiento_actual = datos.deslizamiento_normal
		escape_pos.position = datos.posicion_escape
		humo_rueda_izq.position = datos.posicion_rueda_izq
		humo_rueda_der.position = datos.posicion_rueda_der
		humo_rueda_izq.scale = datos.escala_humo_ruedas
		humo_rueda_der.scale = datos.escala_humo_ruedas
	gestionar_particulas(false)

func _physics_process(delta):
	if not datos:
		return

	var input_acelerar = Input.is_action_pressed("acelerar")
	var input_frenar = Input.is_action_pressed("frenar")
	var input_giro = Input.get_action_strength("derecha") - Input.get_action_strength("izquierda")
	var input_drift = Input.is_action_pressed("mano")
	
	if not is_player_on:
		return
	
	sprite.position = Vector2.ZERO

	var velocidad_giro_actual = datos.velocidad_giro * (1.3 if input_drift else 1.0)
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
		velocidad += direccion_frente * datos.aceleracion * delta
	elif input_frenar:
		velocidad -= direccion_frente * datos.frenado * delta
	else:
		velocidad = velocidad.linear_interpolate(Vector2.ZERO, datos.friccion)

	if velocidad.length() > datos.velocidad_max:
		velocidad = velocidad.clamped(datos.velocidad_max)

	var derrape_lateral = velocidad_costado.length()
	var quemando_goma_arranque = (input_acelerar and velocidad.length() < 120.0)
	
	gestionar_particulas(input_drift or quemando_goma_arranque)

	velocidad = move_and_slide(velocidad)
	
func _procesar_giro(delta, freno_mano):
	rotacion_dir = 0
	if Input.is_action_pressed("izquierda"):
		rotacion_dir -= 1
	if Input.is_action_pressed("derecha"):
		rotacion_dir += 1
		
	var avance_actual = velocidad.length()
	if avance_actual > 30:
		var vel_giro_final = datos.velocidad_giro
		if freno_mano:
			vel_giro_final *= datos.multiplicador_giro_drift
			
		var factor_giro = velocidad.dot(transform.x)
		if factor_giro < 0:
			rotacion_dir *= -1
			
		var angulo_objetivo = rotacion_dir * vel_giro_final
		angulo_giro_actual = lerp(angulo_giro_actual, angulo_objetivo, datos.inercia_giro * delta)
		rotation += angulo_giro_actual * delta
	else:
		angulo_giro_actual = lerp(angulo_giro_actual, 0.0, datos.inercia_giro * delta)

func _procesar_aceleracion(delta, acelerar, frenar, freno_mano):
	if acelerar:
		velocidad += transform.x * datos.aceleracion * delta
	elif frenar:
		velocidad -= transform.x * datos.frenado * delta
	else:
		velocidad = velocidad.move_toward(Vector2.ZERO, datos.friccion * velocidad.length() * delta)
		
	if freno_mano:
		velocidad = velocidad.move_toward(Vector2.ZERO, datos.frenado * 0.5 * delta)
		
	velocidad = velocidad.clamped(datos.velocidad_max)

func _aplicar_friccion_y_drift(delta, freno_mano):
	var deslizamiento_objetivo = datos.deslizamiento_drift if freno_mano else datos.deslizamiento_normal
	deslizamiento_actual = lerp(deslizamiento_actual, deslizamiento_objetivo, datos.velocidad_recuperacion_agarre * delta)
	
	var vector_avance = transform.x * velocidad.dot(transform.x)
	var vector_lateral = transform.y * velocidad.dot(transform.y)
	
	velocidad = vector_avance + (vector_lateral * deslizamiento_actual)

func gestionar_particulas(en_drift):
	var emitiendo_humo = en_drift and velocidad.length() > 100
	if humo_rueda_izq.emitting != emitiendo_humo:
		humo_rueda_izq.emitting = emitiendo_humo
		humo_rueda_der.emitting = emitiendo_humo
		cano_escape.emitting = not emitiendo_humo
