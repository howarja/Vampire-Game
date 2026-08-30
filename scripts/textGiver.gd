extends Control
class_name textGiver

@export var text: RichTextLabel;
@export var audio: AudioStreamPlayer2D;

@export var characterAppearSpeed: float = 0.03;
var currentCharacterDelay = 0;

var currentLine: String;
signal lineComplete;

func triggerDialogue(newLine: String, audioFile: AudioStreamMP3, completeTrigger: Callable):
	text.text = "";
	$"../TextBg".self_modulate = Color.WHITE
	currentLine = newLine;
	if !lineComplete.is_connected(completeTrigger):
		lineComplete.connect(completeTrigger);
	
	# play voice line
	if audio.playing:
		audio.stop();
	audio.stream = audioFile;
	if audioFile!=null:
		audio.play();

func disable():
	text.text = "";
	currentLine = "";
	$"../TextBg".self_modulate = Color.TRANSPARENT

func _process(delta: float) -> void:
	currentCharacterDelay -= delta;
	if currentCharacterDelay <= 0 && currentLine.length()>0:
		text.text += currentLine[0];
		currentLine = currentLine.right(currentLine.length()-1);
		currentCharacterDelay = characterAppearSpeed;
		
		if currentLine.length()<=0:
			lineComplete.emit();
