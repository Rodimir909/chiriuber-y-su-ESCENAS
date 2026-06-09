extends Resource
class_name DatosAuto

export (String) var nombre = "Auto"
export (Texture) var textura_sprite

export (float) var aceleracion = 600.0
export (float) var velocidad_max = 550.0
export (float) var frenado = 400.0
export (float) var friccion = 0.1
export (float) var velocidad_giro = 4.0

export (float) var inercia_giro = 5.0
export (float) var deslizamiento_normal = 0.15
export (float) var deslizamiento_drift = 0.85
export (float) var multiplicador_giro_drift = 1.8
export (float) var velocidad_recuperacion_agarre = 5.0

export (Vector2) var posicion_escape = Vector2(-30, 0)
export (Vector2) var posicion_rueda_izq = Vector2(-20, -15)
export (Vector2) var posicion_rueda_der = Vector2(-20, 15)
export (Vector2) var escala_humo_ruedas = Vector2(1.0, 1.0)
