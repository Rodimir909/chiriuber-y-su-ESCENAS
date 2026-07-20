extends Control

var dale:bool=false
var c:int
var jeje:int



func _ready():
	girar()

func girar():
	jeje=GLOBAL.random(5,50)
	
func _physics_process(delta):
	if dale==true:
		c+=jeje
		$Sprite2.rotation_degrees=c
		if c>=360:
			c=0
			jeje=jeje/2
			print("ay")
		elif jeje<=1:
			girar()
			dale=false
	print(jeje)
			
func _on_Button_pressed():
	dale=true
