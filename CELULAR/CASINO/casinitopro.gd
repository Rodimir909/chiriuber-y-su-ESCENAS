extends Control

var contador:float=0
onready var ppp:bool=false
onready var c:int=0


func _physics_process(delta):
	if ppp==true:
		if c==1:
			$AnimatedSprite.speed_scale=GLOBAL.random(1,100)
			$AnimatedSprite2.speed_scale=GLOBAL.random(1,100)
			$AnimatedSprite3.speed_scale=GLOBAL.random(1,100)
			$AnimatedSprite.playing=true
			$AnimatedSprite2.playing=true
			$AnimatedSprite3.playing=true
		contador+=1
		print(contador)
		if contador==200:
			$AnimatedSprite.playing=false
		if contador==300:
			$AnimatedSprite2.playing=false
		if contador==400:
			$AnimatedSprite3.playing=false
			ppp=false
			contador=0
			$Button.disabled=false
		c=0

func _input(event):
	if event.is_action_pressed("ui_home"):
		get_tree().change_scene("res://CELULAR/CELULAR.tscn")

func _on_Button_pressed():
	ppp=true
	c=1
	$Button.disabled=true
	print("push")
