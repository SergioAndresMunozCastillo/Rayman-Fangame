extends StaticBody2D


const TYPE = "moving_ground"

var timeCont = 0
var vel = Vector2(0,0)

func _physics_process(delta):
	if(timeCont/60 >= 0 && timeCont/60 < 2 ):
		vel.y = 1
	elif(timeCont/60 >= 2 && timeCont/60 < 4):
		vel.y = -1
	else:
		timeCont = 0
	translate(vel)
	timeCont += 1