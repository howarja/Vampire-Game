extends Control
class_name id

@onready var name_label: Label = $TextureRect/Name;
@onready var date_of_birth_label: Label = $TextureRect/DateOfBirth;
@onready var address_label: Label = $TextureRect/Address;
@onready var height_label: Label = $TextureRect/Height;
@onready var weight_label: Label = $TextureRect/Weight;
@onready var hair_label: Label = $TextureRect/Hair;
@onready var eyes_label: Label = $TextureRect/Eyes;
@onready var social_security_label: Label = $"TextureRect/Social Security";

var currentCharacter: character;

func update_id(person: character):
	currentCharacter = person;
	name_label.text = person.fullName;
	date_of_birth_label.text = person.information.dateOfBirth;
	address_label.text = person.information.address;
	height_label.text = person.information.height;
	weight_label.text = person.information.weight;
	hair_label.text = person.information.hair_color;
	eyes_label.text = person.information.eye_color;
	social_security_label.text = person.information.scocial_security;
