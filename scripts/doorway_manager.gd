extends Control
class_name doorwayManager;

@export var text: textGiver;
var lines: Array[String] = [];
@export var audio: Array[AudioStreamWAV] = [];
var currentLine: int = 0;

@export var acceptButton: Button;
@export var declineButton: Button;

var currentCharacter: character;

var holdingInput: bool = false;
var canInput: bool = true;
var inConversation: bool = false;

func _ready() -> void:
	Globals.doorway = self;
	canQuestion(false)
	
	acceptButton.pressed.connect(acceptGuest);
	declineButton.pressed.connect(exitConversation);

func newLine():
	if currentLine<lines.size():
		var currentAudio = null;
		if audio.size()>currentLine:
			currentAudio = audio[currentLine];
		text.triggerDialogue(lines[currentLine], currentAudio, renableInput);
		currentLine+=1;
		canInput = false;
		canQuestion(false);
	else:
		canQuestion(true);

func _process(delta: float) -> void:
	if !inConversation:
		return;
	
	var isInputing = Input.is_anything_pressed();
	if isInputing && !holdingInput && canInput:
		newLine();
	holdingInput = isInputing;

func renableInput():
	canInput = true;

func canQuestion(enabled: bool):
	acceptButton.visible = enabled;
	declineButton.visible = enabled;

func loadCharacter(newCharacter: character):
	currentCharacter = newCharacter;
	beginLine(currentCharacter.introDialaogue, currentCharacter.introVoicelines);

func beginLine(newLines: Array[String], newAudio: Array[AudioStreamWAV]):
	lines = newLines;
	audio = newAudio;
	currentLine = 0;
	inConversation = true;
	newLine();

func exitConversation():
	inConversation = false;
	canQuestion(false);
	lines = [];
	text.disable();
	Globals.player.currentArea.showButtons();
	Globals.player.returnToHallway();
	
func acceptGuest():
	Globals.characters.acceptCharacter(currentCharacter);
	if currentCharacter.vampire:
		Globals.vampiresLetIn+=1;
	else:
		Globals.humansLetIn+=1;
	exitConversation();
