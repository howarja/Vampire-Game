extends Control
class_name endingManager;

@export var endingButton: Button;
@export var confirmButton: Button;
@export var cancelButton: Button;
@export var endingInfo: Control;

func _ready() -> void:
	endingButton.pressed.connect(showInfo);
	cancelButton.pressed.connect(hideInfo);
	confirmButton.pressed.connect(confirmEnding);
	hide();
	Globals.ending = self;
	
func showInfo():
	endingInfo.show();
	endingButton.hide();

func hideInfo():
	endingInfo.hide();
	endingButton.show();

func enableEnding():
	show();

func confirmEnding():
	get_tree().change_scene_to_file("res://scenes/EndingScene.tscn");
