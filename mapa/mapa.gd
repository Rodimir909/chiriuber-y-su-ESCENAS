extends Node2D

func _on_KinematicBody2D_down():
	$KinematicBody2D.position = $Auto/Position2D.global_position
