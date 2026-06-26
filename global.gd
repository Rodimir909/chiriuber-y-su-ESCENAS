extends Node

onready var score : int
onready var time = true

var cartasus = []
var puntosdelus: int = 0
var cartaspc = []
var puntosdelpc: int = 0

var N: int = -1

onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

onready var peso:float 

onready var dolar: float

onready var life : int = 3
onready var sad : float = 0.5

var posicion_aparicion = Vector2.ZERO

var teletrasportarse = false 


func random(a, b):
	rng.randomize()
	return rng.randi_range(int(a), int(b)) # Cambiado a randi para que devuelva enteros exactos para los frames
