extends Node2D

@export_group("Outside Music")
@export var outside_music: Array[AudioStreamWAV];
@export var outside_music_player: AudioStreamPlayer2D;

@export_group("Inside Music")
@export var inside_music: Array[AudioStreamWAV];
@export var inside_music_player: AudioStreamPlayer2D;

func _ready() -> void:
	
	var rand = 0
	
	##outside
	if outside_music.size() > 0:
		rand = randi_range(0,outside_music.size() - 1)
		outside_music_player.stream = outside_music[rand];
	
	##inside
	if inside_music.size() > 0:
		rand = randi_range(0,inside_music.size() - 1)
		inside_music_player.stream = inside_music[rand];
