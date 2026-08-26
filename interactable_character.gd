extends Area2D

var clickable: bool = false;
@export var currentCharacter: character;
@onready var sprite: Sprite2D = $Sprite2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mouseOver);

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Primary") && clickable):
		interact();
		mouseExit();

func interact():
	sprite.visible = false;
	Globals.conversation.loadCharacter(currentCharacter);

func update():
	sprite.visible = true;

func mouseOver() -> void:
	clickable = true;

func mouseExit() -> void:
	clickable = false;
