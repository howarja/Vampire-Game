extends Control
class_name id

@onready var name_label: Label = $Name;
@onready var date_of_birth_label: Label = $DateOfBirth;
@onready var address_label: Label = $Address;
@onready var height_label: Label = $Height;
@onready var weight_label: Label = $Weight;
@onready var hair_label: Label = $Hair;
@onready var eyes_label: Label = $TEyes;
@onready var social_security_label: Label = $"Social Security";

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
