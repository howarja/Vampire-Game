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
@export var ImageBG: AnimationPlayer;
@export var anim: AnimationPlayer;

var holdingInput: bool = false;
var canInput: bool = true;
var inConversation: bool = false;

var pendingImage: Texture2D = null;
var pendingIsID: bool = false;
var imageOnScreen: bool = false;
var imageClickReady: bool = false;

func _ready() -> void:
	Globals.conversation = self;
	exitButton.pressed.connect(exitWithoutFade);
	killButton.pressed.connect(killCharacter);
	canQuestion(false);

func newLine():
	if currentLine<lines.size():
		var currentAudio = null;
		if audio.size()>currentLine:
			currentAudio = audio[currentLine];
		text.triggerDialogue(lines[currentLine], currentAudio, renableInput);
		currentLine+=1;
		canInput = false;
		canQuestion(false);
		anim.play("Talking")
		
		
	else:
		if pendingIsID:
			getOutImage(true, null);
		elif pendingImage != null:
			getOutImage(false, saved_question);
		else:
			canQuestion(true);

func _process(delta: float) -> void:
	if imageOnScreen && imageClickReady:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			canQuestion(true);
			putAwayStuff();
			return;
	
	if !inConversation:
		return;
	
	var isInputing = Input.is_anything_pressed();
	if isInputing && !holdingInput && canInput:
		newLine();
	holdingInput = isInputing;

func renableInput():
	canInput = true;
	anim.play("RESET")

func canQuestion(enabled: bool):
	buttonContainer.visible = enabled;

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
	canQuestion(true)

func loadQuestion(newQuestion: question) -> void:
	lines = newQuestion.answer;
	saved_question = newQuestion;
	
	pendingImage = newQuestion.image;
	pendingIsID = newQuestion.prompt == "Can i see your ID?";

	display.hide();
	_id.hide();
	
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
	phone.put_away_phone();
	saved_question = null;
	Globals.player.fadeTo(Globals.player.currentArea, 1)

func killCharacter():
	# kill the character
	if currentCharacter.vampire:
		Globals.vampiresKilled+=1;
	else: if currentCharacter.host:
		Globals.hostsKilled+=1;
	else:
		Globals.humansKilled+=1;
	
	lastInteracted.kill();
	anim.play("KillAnim");
	Globals.player.fadeHouseMusicOutIn(1);
	
	# disable conversation
	canQuestion(false);
	inConversation = false;
	lines = [];
	saved_question = null;
	phone.put_away_phone();
	text.disable();
	lastInteracted.update();

func exitWithoutFade():
	inConversation = false;
	canQuestion(false);
	lines = [];
	text.disable();
	saved_question = null;
	lastInteracted.update();
	characterSprite.texture = null;
	phone.put_away_phone();
	Globals.player.changeAreaTo(Globals.player.currentArea)
	Globals.actionTaken();

func setAfraid():
	characterSprite.texture = currentCharacter.afraidSprite;
	

func getOutImage(isID: bool,newQuestion: question):
	if !currentCharacter.not_have_id:
		ImageBG.play("FadeIn");
		imageOnScreen = true;
		imageClickReady = false;
		
		if isID:
			_id.show();
		else:
			display.texture = newQuestion.image;
			display.show();
		
		await get_tree().create_timer(0.2).timeout;
		imageClickReady = true;
	else:
		canQuestion(true);
		

func putAwayStuff():
	ImageBG.play("FadeOut");
	display.texture = null;
	display.hide();
	_id.hide();

	pendingImage = null;
	pendingIsID = false;
	imageOnScreen = false;
