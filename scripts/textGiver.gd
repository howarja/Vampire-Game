extends Control
class_name textGiver

@export var text: RichTextLabel;

@export var characterAppearSpeed: float = 0.03;
var currentCharacterDelay = 0;

var currentLine: String;
signal lineComplete;

func triggerDialogue(newLine: String, completeTrigger: Callable):
	text.text = "";
	currentLine = newLine;
	if !lineComplete.is_connected(completeTrigger):
		lineComplete.connect(completeTrigger);

func disable():
	text.text = "";
	currentLine = "";

func _process(delta: float) -> void:
	currentCharacterDelay -= delta;
	if currentCharacterDelay <= 0 && currentLine.length()>0:
		text.text += currentLine[0];
		currentLine = currentLine.right(currentLine.length()-1);
		currentCharacterDelay = characterAppearSpeed;
		
		if currentLine.length()<=0:
			lineComplete.emit();
