extends Control
class_name Phone

func _ready() -> void:
	#$ScrollContainer.hide()
	#pull_out_phone()
	pass;

var currentCharacter: character;
@onready var nameLabel: Label = $ScrollContainer/VBoxContainer/Name;
@onready var date_of_birth: Label = $ScrollContainer/VBoxContainer/DateOfBirth;
@onready var address: Label = $ScrollContainer/VBoxContainer/Address;
@onready var bringing: Label = $ScrollContainer/VBoxContainer/Bringing;
@onready var blood_type: Label = $ScrollContainer/VBoxContainer/BloodType;
@onready var life_status: Label = $ScrollContainer/VBoxContainer/LifeStatus;

func pull_out_phone():
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("pull_out_phone")
	await $AnimatedSprite2D.animation_finished
	$ScrollContainer.show()

func put_away_phone():
	$ScrollContainer.show()
	$AnimatedSprite2D.play_backwards("pull_out_phone")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.hide()

func updatePhone(person: character):
	currentCharacter = person;
	nameLabel.text = person.fullName;
	date_of_birth.text = person.information.dateOfBirth;
	address.text = person.information.address;
	bringing.text = person.information.bringing;
	blood_type.text = person.information.bloodType;
	life_status.text = person.information.lifeStatus;
	pull_out_phone();
