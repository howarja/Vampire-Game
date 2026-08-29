extends Control
class_name conversationManager

@export var text: textGiver;
var lines: Array[String] = [];
var currentLine: int = 0;

@onready var questionButtonScene: PackedScene = preload("res://scenes/question_button.tscn");
var questionButtons: Array[questionButton] = [];
var currentCharacter: character;
var lastInteracted: interactableCharacter;

@export var buttonContainer: Container;
@export var exitButton: Button;
@export var killButton: Button;
@export var characterSprite: Sprite2D;
@export var phone: Phone;
@export var anim: AnimationPlayer;

var holdingInput: bool = false;
var canInput: bool = true;
var inConversation: bool = false;

func _ready() -> void:
	Globals.conversation = self;
	exitButton.pressed.connect(exitConversation)
	killButton.pressed.connect(killCharacter)
	canQuestion(false)

func newLine():
	if currentLine<lines.size():
		text.triggerDialogue(lines[currentLine], renableInput);
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
	buttonContainer.visible = enabled;
	phone.visible = enabled;

func loadCharacter(newCharacter: character, interacted: interactableCharacter):
	currentCharacter = newCharacter;
	lastInteracted = interacted;
	characterSprite.texture = newCharacter.sprite;
	
	# destroy existing buttons and re-instantiate them, quicker than re-using
	for i in questionButtons.size():
		questionButtons[i].queue_free();
	questionButtons = [];
	for i in currentCharacter.questions.size():
		var newButton: questionButton = questionButtonScene.instantiate();
		buttonContainer.add_child(newButton);
		newButton.connectToConvseration(currentCharacter.questions[i], beginLine);
		questionButtons.append(newButton);
	
	inConversation = true;
	phone.updatePhone(newCharacter)
	
	Globals.player.currentArea.hideButtons();
	beginLine(currentCharacter.introDialaogue);

func beginLine(newLines: Array[String]):
	lines = newLines;
	currentLine = 0;
	newLine();

func canStartConversation():
	return !inConversation;

func exitConversation():
	inConversation = false;
	canQuestion(false);
	lines = [];
	text.disable();
	lastInteracted.update();
	characterSprite.texture = null;
	Globals.player.fadeTo(Globals.player.currentArea)

func killCharacter():
	# kill the character
	if currentCharacter.vampire:
		Globals.vampiresKilled+=1;
	else:
		Globals.humansKilled+=1;
	
	lastInteracted.kill();
	characterSprite.texture = currentCharacter.afraidSprite;
	anim.play("KillAnim");
	
	# disable conversation
	canQuestion(false);
	inConversation = false;
	lines = [];
	text.disable();
	lastInteracted.update();

func exitWithoutFade():
	inConversation = false;
	canQuestion(false);
	lines = [];
	text.disable();
	lastInteracted.update();
	characterSprite.texture = null;
	Globals.player.changeAreaTo(Globals.player.currentArea)
