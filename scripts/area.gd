@abstract extends Sprite2D
class_name Area

@export var indoors: bool = true;
@export var movementButtons: Array[Button];
@export var characters: Array[interactableCharacter];

var origin: Vector2;
@export var limit: float=30;
@export var slowness: float = 30;

var center = Vector2(500, 375.0);

func _ready() -> void:
	origin = position;

func _process(delta: float) -> void:
	var mousePos = (center-get_viewport().get_mouse_position())/slowness;
	var clampedX = clamp(mousePos.x, origin.x-limit, origin.x+limit);
	var clampedY = clamp(mousePos.y*1.1, origin.y-limit, origin.y+limit);
	position = lerp(position, Vector2(clampedX, clampedY), delta*5);

func enterArea():
	updateCharacters();
	showButtons();
	show();
	onEntered();

func disableMovement():
	hideButtons();

func exitArea():
	hideCharacters();
	disableMovement();
	hide();

func hideCharacters():
	for i in characters.size():
		characters[i].hideCharacter();

func updateCharacters():
	for i in characters.size():
		characters[i].update();

func hideButtons():
	for i in movementButtons.size():
		movementButtons[i].hide();

func showButtons():
	for i in movementButtons.size():
		movementButtons[i].show();

@abstract func onEntered();
