extends Area2D


func _physics_process(delta):
	print(get_overlapping_bodies())
	pass
func _ready():
	pass # Replace with function body.

func _on_RedLum_body_entered(body):
	if(body.get_name() == "player"):
		get_tree().change_scene("res://Levels/Level2.tscn")
	pass # Replace with function body.
