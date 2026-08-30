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
		
		# if no more characters left, enable ending
		if unEncounteredCharacters.size()<=0:
			Globals.ending.enableEnding();
		return newCharacter;
	else:
		return null;

func acceptCharacter(newCharacter: character) -> void:
	acceptedCharacters.append(newCharacter);

func isActiveCharacter(check: character):
	return acceptedCharacters.has(check);
	
func totalActiveCharacters():
	return acceptedCharacters.size();

func removeCharacter(remove: character) -> void:
	acceptedCharacters.erase(remove);

func noCharacters() -> bool:
	return (acceptedCharacters.size()==0);
