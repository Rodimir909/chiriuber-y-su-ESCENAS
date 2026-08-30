extends Node

var pos

onready var score : int
onready var time = true

var nombre : String 

var posiccion: Vector2

signal viaje
signal establecerpunto
signal fin
signal aceptado

var origen_pasajero : Vector2
var destino_pasajero : Vector2

var buscado : bool = false
var acepta : bool = false

var daa: Vector2=Vector2(478,525)

var enviaje : bool = false

var cartasus = []
var puntosdelus: int = 0
var cartaspc = []
var puntosdelpc: int = 0

var N: int = -1

onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

onready var stamina : float = 100
onready var hambre = 6
onready var sed  = 6

onready var peso:float=900

onready var dolar: float

onready var life : int = 3
onready var sad : float = 0.5

var posicion_aparicion = Vector2.ZERO

var teletrasportarse = false 


func random(a, b):
	rng.randomize()
	return rng.randi_range(int(a), int(b)) # Cambiado a randi para que devuelva enteros exactos para los frames
