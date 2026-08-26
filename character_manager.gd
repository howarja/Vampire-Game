extends Node2D
class_name characterManager

@export var unEncounteredCharacters: Array[character];
var acceptedCharacters: Array[character];

func _ready() -> void:
	Globals.characters = self;

func getCharacter() -> character:
	if unEncounteredCharacters.size()>0:
		var newCharacter: character = unEncounteredCharacters[0];
		unEncounteredCharacters.remove_at(0);
		return newCharacter;
	else:
		return null;
