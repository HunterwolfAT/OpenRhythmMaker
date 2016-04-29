
extends Position2D

# member variables here, example:
# var a=2
# var b="textvar"
var acc = 0
var bpm = 55.0 #undertale song has 110 BPM
var tolerance = 0.6
var limit = 60.0 / bpm
var beatplayed = false
var animoffset = 0.7

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	acc += delta
	if (acc > limit):
		get_node("Position2D/big").beat()
		get_node("Position2D 2/smol").beat()
	if (acc > limit + tolerance):
		get_node("Position2D/big").set_modulate(Color(0.5, 1.0, 0.5)) # make green
		beatplayed = true;
	if (acc > limit + tolerance*2):
		get_node("Position2D/big").set_modulate(Color(1, 1, 1)) # make normal
		acc = 0
		beatplayed = false;


