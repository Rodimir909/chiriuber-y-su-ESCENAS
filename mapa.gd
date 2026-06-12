extends Node2D
var velocidad = 150 

func _process(delta):
	
	$Path2D/PathFollow2D.offset += velocidad * delta
	$ford.global_position = $Path2D/PathFollow2D.global_position
	$ford.rotation = $Path2D/PathFollow2D.rotation
	
	
	
	
	
	
 

