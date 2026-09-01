extends Control

var precio = 0
var metros : int
var tiemp : int
var tr : bool = false
var cancelar : bool = false
var c = 1

#104 nombres
var nombres = [
	"Martin", "Lucas", "Joaquín", "Santiago", "Benjamín", "Nicolás", "Tomás", "Agustín", "Gabriel", "Lautaro",
	"Bruno", "Thiago", "Valentín", "Felipe", "Gonzalo", "Franco", "Santino", "Julián", "Máximo", "Felicitas",
	"Rodrigo", "Emiliano", "Matías", "Diego", "Leonardo", "Manuel", "Samuel", "Ramiro", "Facundo", "Damián",
	"Marcos", "Ezequiel", "Alan", "Iván", "Kevin", "Brian", "Alex", "Adrián", "Sebastián", "Esteban", 
	"Mauricio", "Cristian", "Gastón", "Nahuel", "Enzo", "Luciano", "Martín", "Javier", "Fernando", "Carlos",
	"Sofía", "Valentina", "Lucía", "Martina", "Camila", "Emma", "Isabella", "Catalina", "Mia", "Delfina",
	"Elena", "Olivia", "Victoria", "Zoe", "Paula", "Renata", "Julieta", "Antonella", "Alma", "Josefina",
	"Luana", "Jazmín", "Micaela", "Abríl", "Bianca", "Lola", "Florencia", "Mariana", "Carla", "Romina",
	"Daniela", "Natalia", "Andrea", "Laura", "Sara", "Valeria", "Carolina", "Rocío", "Sabrina", "Vanessa",
	"Brenda", "Agostina", "Pilar", "Milagros", "Sol", "Lara", "Nicole", "Belén", "Ariana", "Tatiana", 
	"IGNACIO CHIRINO", "CIRO WENDLER", "ISHMAEL SIMONCINI", "ROMAN CARRIZO", "GONZALO CHIRINO", "NAHUEL ROJAS"
]

func _ready():
	GLOBAL.connect("fin", self, "fina")



func _physics_process(delta):
	if tr==true:
		$"fondo viajes/ProgressBar".value-=1
		if $"fondo viajes/ProgressBar".value==0:
			GLOBAL.acepta=false
			$"fondo viajes".visible=false
			tr=false
			print("barra")
			c=1
			tiempo()

			

func fina():
	$"start-stop".visible=true
	$"fondo viajes/ProgressBar".visible=true
	tr=false
	$"fondo viajes/aceptar".visible=true
	$"fondo viajes/rechazar".visible=true
	$"fondo viajes/Label".visible=false
	$"fondo viajes".visible=false
	GLOBAL.peso+=int(precio)
	print("final")
	c+=1
	tiempo()



func zonaorigen():
	if GLOBAL.origen_pasajero.x<7114 and GLOBAL.origen_pasajero.y>0:
		$"fondo viajes/origen".text="Zona Noroeste"
	elif GLOBAL.origen_pasajero.x>7114 and GLOBAL.origen_pasajero.y>0:
		$"fondo viajes/origen".text="Zona Noreste"
	elif GLOBAL.origen_pasajero.x<7114 and GLOBAL.origen_pasajero.y<0:
		$"fondo viajes/origen".text="Zona Suroeste"
	elif GLOBAL.origen_pasajero.x>7114 and GLOBAL.origen_pasajero.y<0 and GLOBAL.origen_pasajero.y>3594:
		$"fondo viajes/origen".text="Zona Noreste"
	elif GLOBAL.origen_pasajero.x>7114 and GLOBAL.origen_pasajero.y>3594:
		$"fondo viajes/origen".text="Zona Sur"

func zonadestino():
	if GLOBAL.destino_pasajero.x<7114 and GLOBAL.destino_pasajero.y>0:
		$"fondo viajes/destino".text="Zona Noroeste"
	elif GLOBAL.destino_pasajero.x>7114 and GLOBAL.destino_pasajero.y>0:
		$"fondo viajes/destino".text="Zona Noreste"
	elif GLOBAL.destino_pasajero.x<7114 and GLOBAL.destino_pasajero.y<0:
		$"fondo viajes/destino".text="Zona Suroeste"
	elif GLOBAL.destino_pasajero.x>7114 and GLOBAL.destino_pasajero.y<0 and GLOBAL.destino_pasajero.y<3594:
		$"fondo viajes/destino".text="Zona Noreste"
	elif GLOBAL.destino_pasajero.x>7114 and GLOBAL.destino_pasajero.y>3594:
		$"fondo viajes/destino".text="Zona Sur"



func tiempo():
	if c==1:
		tiemp=GLOBAL.random(5, 120)
		$generacion.start(tiemp)
		print("tiempo=", tiemp)



func generacion():
	$"fondo viajes/ProgressBar".value=1000
	GLOBAL.emit_signal("viaje")
	aleo()
	GLOBAL.enviaje=true
	$"fondo viajes".visible=true
	tr=true
	print("a")



func aleo():
	$"fondo viajes/nombres".text=nombres[GLOBAL.random(0,105)]
	zonaorigen()
	zonadestino()
	metros= int((GLOBAL.origen_pasajero.distance_to(GLOBAL.destino_pasajero))/16)
	if metros>=1000:
		$"fondo viajes/distancia".text=str(metros/1000.0, 0,1)+"km"
	else:
		$"fondo viajes/distancia".text=str(metros)+"m"
	precio = stepify((200+(metros*0.5)),10)
	$"fondo viajes/precio".text=str("$", precio)


func _on_startstop_pressed():
	if $"start-stop/AnimatedSprite".animation=="start":
		$"start-stop/AnimatedSprite".play("stop")
		print("start")
		tiempo()
	else:
		$"start-stop/AnimatedSprite".play("start")
		print("stop")
		$generacion.stop()
		GLOBAL.acepta=false
		$"fondo viajes".visible=false
		GLOBAL.enviaje=false





func _on_rechazar_pressed():
	print("rechazado")
	GLOBAL.acepta=false
	$"fondo viajes".visible=false
	tr=false
	c=1
	tiempo()





func _on_aceptar_pressed():
	print("aceptado")
	$"start-stop".visible=false
	$"fondo viajes/ProgressBar".visible=false
	$"fondo viajes/ProgressBar".value=1000
	tr=false
	$"fondo viajes/aceptar".visible=false
	$"fondo viajes/rechazar".visible=false
	$"fondo viajes/Label".visible=true
	GLOBAL.acepta=true
	GLOBAL.emit_signal("aceptado")





func _on_generacion_timeout():
	c=0
	generacion()

