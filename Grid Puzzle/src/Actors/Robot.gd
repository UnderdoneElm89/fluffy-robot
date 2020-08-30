extends KinematicBody2D


# Declare member variables here. Examples:
var dir = Vector2.ZERO
var speed = 50
var moving = false
var atStart = true
var init_pos
var countdown = 0

func _ready():
	init_pos = get_position()
func start():
	var pos = get_position()
	var tile = get_tree().get_current_scene().get_node("TileMap").get_cellv(get_tree().get_current_scene().get_node("TileMap").world_to_map(pos))
	change_dir(tile)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(countdown > 0):
		countdown -= 0.2
	if(Input.is_action_just_pressed("Reset")):
		position = init_pos
		get_node("CollisionShape2D").disabled = false
		show()
		moving = false
		atStart = true
	if(Input.is_action_just_pressed("Play")):
		if(atStart):
			start()
			atStart = false
		moving = not moving
	if(moving):
		var pos = get_position()
		if(countdown <= 0 && int(pos.x-7)%16 < 2 && int(pos.y-7)%16 < 2):
			var tile = get_tree().get_current_scene().get_node("TileMap").get_cellv(get_tree().get_current_scene().get_node("TileMap").world_to_map(pos))
			if(tile != 0):
				change_dir(tile)
		move_and_slide(speed*dir)


func change_dir(tile):
	if(tile == 0):
		return
		
	countdown = 1
	if(tile == 1):
		dir = Vector2(1,0)
		return
	if(tile == 2):
		dir = Vector2(0,-1)
		return
	if(tile == 3):
		dir = Vector2(-1,0)
		return
	if(tile == 4):
		dir = Vector2(0,1)
		return
	if(tile == 5):
		dir = dir.rotated(PI/2)
		return
	if(tile == 6):
		dir = dir.rotated(-PI/2)
		return
	if(tile == 7):
		dir = Vector2(0,0)
		get_node("CollisionShape2D").disabled = true
		hide()
		return
	if(tile == 22):
		dir = Vector2(0,0)
		return
	if(tile == 23):
		dir = dir.rotated(PI)
		return
	print(tile)
