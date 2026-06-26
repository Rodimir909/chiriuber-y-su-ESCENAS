extends Node

onready var score : int

onready var time = true

onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

onready var peso:float 

onready var dolar:float

onready var life : int = 3

onready var sad : float = 0.5

var posicion_aparicion = Vector2.ZERO

var teletrasportarse = false 


func random(a, b):
	rng.randomize()
	return rng.randf_range(a, b)
 
