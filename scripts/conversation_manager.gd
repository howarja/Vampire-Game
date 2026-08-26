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

var holdingInput: bool = false;
var canInput: bool = true;
var inConversation: bool = false;

func _ready() -> void:
	Globals.conversation = self;
	exitButton.pressed.connect(exitConversation)
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

func loadCharacter(newCharacter: character, interacted: interactableCharacter):
	currentCharacter = newCharacter;
	lastInteracted = interacted;
	
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
	Globals.player.currentArea.showButtons();
