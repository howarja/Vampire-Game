extends Control

@export var text: textGiver;
@export var lines: Array[String];
var currentLine: int = 0;

var holdingInput: bool = false;
var canInput: bool = true;

func _ready() -> void:
	newLine();
	
func newLine():
	if currentLine<lines.size():
		text.triggerDialogue(lines[currentLine], renableInput);
		currentLine+=1;
		canInput = false;

func _process(delta: float) -> void:
	var isInputing = Input.is_anything_pressed();
	if isInputing && !holdingInput && canInput:
		newLine();
	holdingInput = isInputing;

func renableInput():
	canInput = true;
