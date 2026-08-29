@abstract extends Sprite2D
class_name Area

@export var movementButtons: Array[Button];
@export var characters: Array[interactableCharacter];

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
