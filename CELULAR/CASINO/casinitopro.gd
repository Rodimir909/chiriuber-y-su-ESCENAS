extends Control

var contador:float=0
onready var ppp:bool=false
onready var c:int=0

var apuesta:int

var hab: bool = true

var eleccion = [0, 0, 0]

func analizar():
	if ($AnimatedSprite.frame==$AnimatedSprite2.frame and $AnimatedSprite.frame==$AnimatedSprite3.frame and $AnimatedSprite2.frame==$AnimatedSprite3.frame) and $AnimatedSprite.frame==0:
		GLOBAL.peso+=apuesta*100
	elif ($AnimatedSprite.frame==$AnimatedSprite2.frame and $AnimatedSprite.frame==$AnimatedSprite3.frame and $AnimatedSprite2.frame==$AnimatedSprite3.frame) and $AnimatedSprite.frame==1:
		GLOBAL.peso+=apuesta*25
	elif ($AnimatedSprite.frame==$AnimatedSprite2.frame and $AnimatedSprite.frame==$AnimatedSprite3.frame and $AnimatedSprite2.frame==$AnimatedSprite3.frame) and ($AnimatedSprite.frame==2 or $AnimatedSprite.frame==3 or $AnimatedSprite.frame==4):
		GLOBAL.peso+=apuesta*10
	elif $AnimatedSprite.frame>=2 and $AnimatedSprite2.frame>=2 and $AnimatedSprite3.frame>=2:
		GLOBAL.peso+=apuesta*2
func _ready():
	if GLOBAL.peso>=100:
		apuesta=100
	else:
		apuesta=GLOBAL.peso
	$VBoxContainer/HBoxContainer/apuesta.text=str("$", apuesta)
	if apuesta>0:
		$Button.disabled=false
	else:
		$Button.disabled=true

func _physics_process(delta):
	if ppp==true:
		if c==1:
			for i in range (3):
				eleccion[i]= GLOBAL.random(0, 4)
				
		contador+=1

		if contador==200:
			$AnimatedSprite.playing=false
			$AnimatedSprite.frame=eleccion[0]
		if contador==300:
			$AnimatedSprite2.playing=false
			$AnimatedSprite2.frame=eleccion[1]
		if contador==400:
			$AnimatedSprite3.playing=false
			$AnimatedSprite3.frame=eleccion[2]
			ppp=false
			contador=0
			$Button.disabled=false
			hab=true
			analizar()
		c=0

func _on_Button_pressed():
	ppp=true
	c=1
	GLOBAL.peso-=apuesta
	hab=false
	$Button.disabled=true
	$AnimatedSprite.playing=true
	$AnimatedSprite2.playing=true
	$AnimatedSprite3.playing=true

func _on_MAS_pressed():
	if hab==true:
		if GLOBAL.peso>apuesta:
			apuesta+=100
			if apuesta>GLOBAL.peso:
				apuesta=GLOBAL.peso
				$VBoxContainer/HBoxContainer/apuesta.text=str("$",apuesta)
			$VBoxContainer/HBoxContainer/apuesta.text=str("$",apuesta)
		else:
			$VBoxContainer/HBoxContainer/apuesta.modulate=Color.red
			yield(get_tree().create_timer(0.15), "timeout")
			$VBoxContainer/HBoxContainer/apuesta.modulate=Color.white

func _on_MENOS_pressed():
	if hab==true:
		if apuesta>0 and apuesta<=100:
			$VBoxContainer/HBoxContainer/apuesta.modulate=Color.red
			yield(get_tree().create_timer(0.15), "timeout")
			$VBoxContainer/HBoxContainer/apuesta.modulate=Color.white
			$VBoxContainer/HBoxContainer/apuesta.text=str("$",apuesta)
		elif apuesta>100:
			apuesta-=100
			$VBoxContainer/HBoxContainer/apuesta.text=str("$",apuesta)
		else:
			$VBoxContainer/HBoxContainer/apuesta.text=str("$",apuesta)
