extends Control
class_name textGiver

@export var text: RichTextLabel;

@export var characterAppearSpeed: float = 0.03;
var currentCharacterDelay = 0;

@export var currentLine: String;
signal lineComplete;

func triggerDialogue(newLine: String, completeTrigger: Callable):
	text.text = "";
	currentLine = newLine;
	lineComplete.connect(completeTrigger);

func _process(delta: float) -> void:
	currentCharacterDelay -= delta;
	if currentCharacterDelay <= 0 && currentLine.length()>0:
		text.text += currentLine[0];
		currentLine = currentLine.right(currentLine.length()-1);
		currentCharacterDelay = characterAppearSpeed;
		
		if currentLine.length()<=0:
			lineComplete.emit();
