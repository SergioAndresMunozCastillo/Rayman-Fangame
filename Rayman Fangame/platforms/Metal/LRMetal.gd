extends StaticBody2D

var TYPE = "moving_ground"

var timeCont = 0
var vel = Vector2(0,0)

func _physics_process(delta):
	if(timeCont/60 >= 0 && timeCont/60 < 3 ):
		vel.x = 1
	elif(timeCont/60 >= 2 && timeCont/60 < 6):
		vel.x = -1
	else:
		timeCont = 0
	translate(vel)
	timeCont += 1