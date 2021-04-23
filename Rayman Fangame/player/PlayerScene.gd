extends KinematicBody2D

onready var sprite = get_node("sprites")
onready var ground = preload("res://platforms/Rock/LRRock.tscn")
const TYPE = "player"
const GRAVITY = 200
const MAX_SPEED = 300

var accV = Vector2(0,GRAVITY)
var vel = Vector2()
var jumpSpeed = -255
var canJump = false
var canFly = true
var isFlying = false

var flyCont = 0

#Metodo principal de Rayman
func _physics_process(delta):
	#Aqui se hacen cambios en la velocidad relativa de Rayman al pulsar determinada tecla
	if Input.is_key_pressed(KEY_LEFT):
		vel.x -= 150
	if Input.is_key_pressed(KEY_RIGHT):
		vel.x += 150
	if Input.is_action_pressed("jump"):
		if(canJump):
			accV.y = jumpSpeed
			vel.y += accV.y
			canJump = false

	if Input.is_key_pressed(KEY_UP):
		if(canFly):
			isFlying = true
	if(flyCont/60 >= 1):
		isFlying = false
		canFly = false
	if(isFlying):
		accV.y = 40
		vel.y = accV.y
		flyCont += 1
	else:
		accV.y += 15
		vel.y += accV.y
	if(get_slide_collision(get_slide_count() -1) != null):
		var objCollided = get_slide_collision(get_slide_count() -1).collider
		if(objCollided.get_name() == "LRRock" || objCollided.get_name() == "LRMetal"):
			print("it collided", objCollided.vel)
			vel.x += objCollided.vel.x * 60
			vel.y += objCollided.vel.y * 60
	vel.y = clamp(vel.y, jumpSpeed, GRAVITY)
	vel.x = clamp(vel.x, -MAX_SPEED, MAX_SPEED)
	set_animation(vel)
	#La gravedad actua constantemente por cada frame dle juego, moviendo a rayman hacia abajo siempre
	self.move_and_slide(vel, Vector2(0,-1))
	if(is_on_floor()):
		canJump = true
		flyCont = 0
	else:
		canFly = true
		canJump = false
	if(canJump):
		canFly = false
		isFlying = false
	vel.x = 0
	print(is_on_floor())
	print("canfly : ", canFly)

#Bastante self explanatory: este metodo se encarga de determinar cual es la animacion segun lo que ocurra con Rayman
func set_animation(velocity):
	if(velocity == Vector2(0,0)):
		sprite.play("idle")
	elif ((Input.is_key_pressed(KEY_LEFT) || Input.is_key_pressed(KEY_RIGHT)) && (velocity.x > 0 || velocity.x < 0) && (get_slide_collision(get_slide_count() -1) != null)):
		if(velocity.x < 0):
			sprite.set_flip_h(true)
		else:
			sprite.set_flip_h(false)
		sprite.play("running")
	elif ((canJump == false) && (velocity.y < 0)):
		if(velocity.x < 0):
			sprite.set_flip_h(true)
		elif (velocity.x > 0):
			sprite.set_flip_h(false)
		sprite.play("jumping")
	elif ((get_slide_collision(get_slide_count() -1) == null) && (isFlying == true)):
		if(velocity.x < 0):
			sprite.set_flip_h(true)
		elif (velocity.x > 0):
			sprite.set_flip_h(false)
		sprite.play("flying")
	elif (velocity.y > 0 && (get_slide_collision(get_slide_count() -1) == null)):
		if(velocity.x < 0):
			sprite.set_flip_h(true)
		elif (velocity.x > 0):
			sprite.set_flip_h(false)
		sprite.play("falling")
	else:
		sprite.play("idle")

func _ready():
	vel.y = GRAVITY
	pass # Replace with function body.