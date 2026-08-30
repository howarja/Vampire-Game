extends Control
class_name conversationManager

@export var text: textGiver;
var lines: Array[String] = [];
var audio: Array[AudioStreamWAV] = [];
var currentLine: int = 0;

var saved_question: question;

@onready var questionButtonScene: PackedScene = preload("res://scenes/question_button.tscn");
var questionButtons: Array[questionButton] = [];
var currentCharacter: character;
var lastInteracted: interactableCharacter;

@export var buttonContainer: Container;
@export var exitButton: Button;
@export var killButton: Button;
@export var characterSprite: Sprite2D;
@export var display: TextureRect;
@export var phone: Phone;
@export var _id: id;
@export var anim: AnimationPlayer;

var holdingInput: bool = false;
var canInput: bool = true;
var inConversation: bool = false;

func _ready() -> void:
	Globals.conversation = self;
	exitButton.pressed.connect(exitConversation);
	killButton.pressed.connect(killCharacter);
	canQuestion(false);

func newLine():
	if currentLine<lines.size():
		text.triggerDialogue(lines[currentLine], null, renableInput);
		currentLine+=1;
		canInput = false;
		canQuestion(false);
		anim.play("Talking")
		
		if saved_question!=null:
			if saved_question.prompt != "Can i see your ID?":
				_id.hide();
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
	_id.hide();
	if saved_question!=null:
		if saved_question.prompt == "Can i see your ID?":
			_id.show();
	anim.play("RESET")

func canQuestion(enabled: bool):
	buttonContainer.visible = enabled;
	phone.visible = enabled;

func loadCharacter(newCharacter: character, interacted: interactableCharacter):
	currentCharacter = newCharacter;
	lastInteracted = interacted;
	characterSprite.texture = newCharacter.interiorSprite;
	
	# destroy existing buttons and re-instantiate them, quicker than re-using
	for i in questionButtons.size():
		questionButtons[i].queue_free();
	questionButtons = [];
	for i in currentCharacter.questions.size():
		var newButton: questionButton = questionButtonScene.instantiate();
		buttonContainer.add_child(newButton);
		newButton.connectToConvseration(currentCharacter.questions[i], loadQuestion);
		questionButtons.append(newButton);
	
	inConversation = true;
	phone.updatePhone(newCharacter)
	_id.update_id(newCharacter)
	saved_question = null;
	
	Globals.player.currentArea.hideButtons();
	reparent(Globals.player.currentArea, true);
	beginLine(currentCharacter.introDialaogue, currentCharacter.introVoicelines);

func loadQuestion(newQuestion: question) -> void:
	lines = newQuestion.answer;
	saved_question = newQuestion;
	if newQuestion.image!=null:
		display.texture = newQuestion.image;
		display.show();
	else:
		display.hide();
	audio = newQuestion.audio;
	currentLine = 0;
	newLine();

func beginLine(newLines: Array[String], audioFiles: Array[AudioStreamWAV]) -> void:
	lines = newLines;
	audio = audioFiles;
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
	display.hide();
	_id.hide();
	phone.put_away_phone();
	saved_question = null;
	Globals.player.fadeTo(Globals.player.currentArea, 1)

func killCharacter():
	# kill the character
	if currentCharacter.vampire:
		Globals.vampiresKilled+=1;
	else:
		Globals.humansKilled+=1;
	
	lastInteracted.kill();
	anim.play("KillAnim");
	Globals.player.fadeHouseMusicOutIn(1);
	
	# disable conversation
	canQuestion(false);
	inConversation = false;
	lines = [];
	display.hide();
	saved_question = null;
	_id.hide();
	phone.put_away_phone();
	text.disable();
	lastInteracted.update();

func exitWithoutFade():
	inConversation = false;
	canQuestion(false);
	lines = [];
	text.disable();
	_id.hide();
	saved_question = null;
	lastInteracted.update();
	characterSprite.texture = null;
	display.hide();
	phone.put_away_phone();
	Globals.player.changeAreaTo(Globals.player.currentArea)

func setAfraid():
	characterSprite.texture = currentCharacter.afraidSprite;
