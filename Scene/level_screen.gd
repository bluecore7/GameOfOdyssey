extends Node2D
@onready var Health_container: HBoxContainer = $HealthContainer
@onready var athena_1: TextureRect = $HealthContainer/Athena1
@onready var athena_2: TextureRect = $HealthContainer/Athena2
@onready var athena_3: TextureRect = $HealthContainer/Athena3
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer
@onready var stage_name : RichTextLabel =$Stage_Name
var time

func _ready() -> void:
	if Global.lives <= 0:
		get_tree().change_scene_to_file("res://Scene/game_over.tscn")
		return

	if Global.minigames_done < 3:
		Global.minigames_done += 1
		
	stage_name.text = Global.Game_Name.get(Global.minigames_done, "") 
	
	# Start typewriter effect in code
	type_out(stage_name, 0.06)
		
	await Timer(3.0)
	
	if Global.minigames_done <= 3:
		get_tree().change_scene_to_file("res://Scene/minigame_" + str(Global.minigames_done) + ".tscn")
	else:
		get_tree().change_scene_to_file("res://Scene/title_screen.tscn")

# Helper function to type character by character
func type_out(label: RichTextLabel, speed: float) -> void:
	label.visible_characters = 0
	var total_chars = label.get_total_character_count()
	
	for i in range(total_chars + 1):
		label.visible_characters = i
		# If you have an AudioStreamPlayer node, you can play sound here:
		# $TypeSound.play()
		await get_tree().create_timer(speed).timeout
		
func _process(_delta: float) -> void: # runs EVERY FRAME
	match Global.lives: # asks or checks if lives is equal to one of 
#these values, cool hack. by the way this is a horrid way to illustrate the 
#lives visually so later you can always find alternative code. Now, dw abt it.


		2:
			athena_1.hide()
		1:
			athena_1.hide()
			athena_2.hide()
		0:
			athena_1.hide()
			athena_2.hide()
			athena_3.hide()
	
	timer.text = str(time) # make ths text reflect the value of the time variable. this makes names easier. the str() converts the int to a String
	level.text = "Level " + str(Global.minigames_done) # this tells you want minigame you're on using concatenation (google the word yo)

func Timer(start_time: float): # making a new function for timer countdown!
	# we want the timer to go down, and when it reaches 0 it transitions 
	# to the next scene!
	
	time = start_time # make the timer, which is reflected through the timer text, start at your desired number
	
	while time > 0.0: # run if timer hasnt reached 0
		await wait(0.1) # asks script to wait on this function. the 'wait' name for the function does nothing here, as await is just telling the scrpit to wait for the function to complete before progressing
		time -= 0.1 # remove 0.1
		# progressively get the value smaller and smaller
	
	#when timer reaches 0
	return

func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait, dw abt this being complex '''
