extends Area2D
class_name interactableCharacter

var clickable: bool = false;
@export var currentCharacter: character;
@onready var sprite: Sprite2D = $Sprite2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(mouseOver);
	mouse_exited.connect(mouseExit)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Primary") && clickable):
		interact();
		mouseExit();

func interact():
	if Globals.conversation.canStartConversation():
		hideCharacter();
		Globals.conversation.loadCharacter(currentCharacter, self);

func hideCharacter():
	sprite.visible = false;

func update():
	# add if alive
	sprite.visible = true;

func mouseOver() -> void:
	if Globals.conversation.canStartConversation() && sprite.visible:
		clickable = true;

func mouseExit() -> void:
	clickable = false;
