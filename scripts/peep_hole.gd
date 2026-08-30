extends Area

var currentCharacter: character;
@export var characterSprite: Sprite2D;
@export var maxTimer: Timer;
var timerFinished: bool = false;

func _ready() -> void:
	maxTimer.timeout.connect(timerFinish);

func newGuest():
	currentCharacter = Globals.characters.getCharacter();
	if currentCharacter != null:
		characterSprite.texture = currentCharacter.outDoorSprite;
		Globals.doorway.loadCharacter(currentCharacter);
		hideButtons();
		maxTimer.start();
		timerFinished = false;

func timerFinish():
	timerFinished = true;

func onEntered():
	if Globals.actionTimer<=0||Globals.characters.noCharacters() && timerFinished:
		newGuest();
		Globals.resetActionTimer(1);
	else:
		characterSprite.texture = null;
