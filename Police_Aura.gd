extends KinematicBody2D

@export var velocidad: float = 200
@export var jugador: Node2D # Arrastra al jugador aquí desde el inspector

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _physics_process(_delta: float) -> void:
	# 1. Si el jugador no existe, no hacemos nada
	if not jugador:
		return
		
	# 2. Le damos al GPS la posición actual del jugador
	navigation_agent.target_position = jugador.global_position
	
	# 3. Si ya llegamos al jugador, nos detenemos
	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	# 4. Obtenemos el siguiente punto intermedio de la ruta para esquivar obstáculos
	var siguiente_punto: Vector2 = navigation_agent.get_next_path_position()
	
	# 5. Calculamos la dirección hacia ese punto intermedio
	var direccion: Vector2 = global_position.direction_to(siguiente_punto)
	
	# 6. Asignamos la velocidad y movemos el auto
	velocity = direccion * velocidad
	move_and_slide()
	
	# Opcional: Hacer que el auto mire hacia donde conduce
	if velocity.length() > 0:
		rotation = velocity.angle()
