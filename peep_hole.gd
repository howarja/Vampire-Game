extends Area

var currentCharacter: character;
@export var characterSprite: Sprite2D;

func newGuest():
	currentCharacter = Globals.characters.getCharacter();
	if currentCharacter != null:
		characterSprite.texture = currentCharacter.sprite;
		Globals.doorway.loadCharacter(currentCharacter);
		hideButtons();

func onEntered():
	newGuest();
