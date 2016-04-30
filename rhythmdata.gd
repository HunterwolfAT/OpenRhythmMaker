
extends Position2D

var acc = 0
var bpm = 270.0 # 270 for hole in one
var tolerance = 0.3
var limit = 60.0 / bpm
var beatplayed = false
var animoffset = 0.0
var offset = 1 #1 for holeinone
var offsetover = false

var beats = 0
var hit = 0
var fail = 0
var missed = 0

var hitframe = false #the timefrime when a input is registered as a hit
var washit = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	set_process_input(true)
	pass

func _process(delta):
	acc += delta
	if (!offsetover):
		if (acc >= offset):
			offsetover = true
			acc = 0
	else:
		if (acc >= limit - animoffset && !beatplayed):
			get_node("Position2D/big").beat()
			get_node("Position2D 2/smol").beat()
			beatplayed = true;
		if (acc >= limit - animoffset):
			get_node("Position2D/big").set_modulate(Color(0.5, 1.0, 0.5)) # make green
			hitframe = true
		if (acc >= limit + tolerance - animoffset):
			get_node("Position2D/big").set_modulate(Color(1, 1, 1)) # make normal
			acc -= limit + tolerance
			beatplayed = false;
			beats += 1
			if (!washit):
				missed += 1
			washit = false
			hitframe = false
			get_node("L_Beats").set_text("Beats: " + str(beats) + " | Hit: " + str(hit) + " | Wrong: " +str(missed + fail) )

func _input(event):
	if (event.type == InputEvent.KEY):
		if (Input.is_key_pressed(KEY_SPACE)):
			if (hitframe):
				hit += 1
				washit = true
			else:
				fail += 1
		
		#Quit the game
		if (Input.is_key_pressed(KEY_ESCAPE)):
			get_tree().quit()
