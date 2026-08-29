extends Control
class_name Phone


var currentCharacter: character;
@onready var nameLabel: Label = $TextureRect/ScrollContainer/VBoxContainer/Name;
@onready var date_of_birth: Label = $TextureRect/ScrollContainer/VBoxContainer/DateOfBirth;
@onready var address: Label = $TextureRect/ScrollContainer/VBoxContainer/Address;
@onready var bringing: Label = $TextureRect/ScrollContainer/VBoxContainer/Bringing;
@onready var blood_type: Label = $TextureRect/ScrollContainer/VBoxContainer/BloodType;
@onready var life_status: Label = $TextureRect/ScrollContainer/VBoxContainer/LifeStatus;

func updatePhone(person: character):
	currentCharacter = person;
	nameLabel.text = person.fullName;
	date_of_birth.text = person.information.dateOfBirth;
	address.text = person.information.address;
	bringing.text = person.information.bringing;
	blood_type.text = person.information.bloodType;
	life_status.text = person.information.lifeStatus;
