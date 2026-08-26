extends Area

var currentCharacter: character;
@export var characterSprite: Sprite2D;

func newGuest():
	currentCharacter = Globals.characters.getCharacter();
	print("Work");
	if currentCharacter != null:
		characterSprite.texture = currentCharacter.sprite;

func onEntered():
	print("Work1");
	newGuest();
