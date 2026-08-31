extends Area

var currentCharacter: character;
@export var characterSprite: Sprite2D;
@export var maxTimer: Timer;
@export var emptyTimer: Timer;
@export var knockingSFX: AudioStreamPlayer2D;
var maxTimerFinished: bool = false;
var emptyTimerFinsihed: bool = false;

var guestWaiting: bool = false;

func _ready() -> void:
	maxTimer.timeout.connect(maxTimerFinish);
	emptyTimer.timeout.connect(emptyTimerFinish);

func newGuest():
	currentCharacter = Globals.characters.getCharacter();
	if currentCharacter != null:
		Globals.doorway.loadCharacter(currentCharacter);
		characterSprite.texture = currentCharacter.outDoorSprite;
		hideButtons();

		maxTimer.start();
		emptyTimer.start();
		maxTimerFinished = false;
		emptyTimerFinsihed = false;
		guestWaiting = false;
	else:
		print("no one left") ## this kinda fixs the bug?

func maxTimerFinish():
	maxTimerFinished = true;

func emptyTimerFinish():
	emptyTimerFinsihed = true;

func _process(delta: float) -> void:
	if Globals.player.currentArea!=self:
		if Globals.actionTimer<=0 || maxTimerFinished || Globals.characters.noCharacters():
			if !guestWaiting:
				guestWaiting = true;
				knockingSFX.play();

func onEntered():
	knockingSFX.stop();
	if guestWaiting:
		Globals.resetActionTimer(min(Globals.characters.totalActiveCharacters()+1, 3));
		newGuest();
	else:
		characterSprite.texture = null;
