extends Node2D

export (PackedScene) var ENEMYSMALL
export (PackedScene) var ENEMYMEDIUM
export (PackedScene) var ENEMYBIG
export (PackedScene) var VIDA
export (PackedScene) var DISPA


func _ready():
	randomize()
	$Timersmall.start()
	$Timermedium.start()
	$Timerbig.start()
	$Timervida.start()
	$Timerdispa.start()

func _physics_process(delta):
	$Background.scroll_base_offset +=Vector2(0,1)*8*delta
	
	

func _on_deathzone_area_entered(area):
	if area.is_in_group("enemy"):
		if GLOBAL.life>=0:
			GLOBAL.life -= 1
		if GLOBAL.life<=0:
			GLOBAL.life=0
	if area.is_in_group("enemybig"):
		if GLOBAL.life>=0:
			GLOBAL.life -=3
		if GLOBAL.life<=0:
			GLOBAL.life=0
	if area.is_in_group("enemymedium"):
		if GLOBAL.life>=0:
			GLOBAL.life -=2
		if GLOBAL.life<=0:
			GLOBAL.life=0




func _on_Timermedium_timeout():
	if GLOBAL.life > 0:
		var enemymedium = ENEMYMEDIUM.instance()
		$enemymedium/PathFollow2D.set_offset(randi())
		enemymedium.position = $enemymedium/PathFollow2D.position
		add_child(enemymedium)
		



func _on_Timersmall_timeout():
	if GLOBAL.life > 0:
		var enemysmall = ENEMYSMALL.instance()
		$enemysmall/PathFollow2D.set_offset(randi())
		enemysmall.position = $enemysmall/PathFollow2D.position
		add_child(enemysmall)
		



func _on_Timerbig_timeout():
	if GLOBAL.life > 0:
		var enemybig = ENEMYBIG.instance()
		$enemybig/PathFollow2D.set_offset(randi())
		enemybig.position = $enemybig/PathFollow2D.position
		add_child(enemybig)


func _on_Timervida_timeout():
	var vida = VIDA.instance()
	$VIDAS/vidas.set_offset(randi())
	vida.position = $VIDAS/vidas.position
	add_child(vida)
	



func _on_Timerdispa_timeout():
	var dispa = DISPA.instance()
	$DISPA/dispa.set_offset(randi())
	dispa.position = $DISPA/dispa.position
	add_child(dispa)







