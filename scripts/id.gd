extends Control
class_name id

@onready var name_label: Label = $Name;
@onready var date_of_birth_label: Label = $DateOfBirth;
@onready var address_label: Label = $Address;
@onready var height_label: Label = $Height;
@onready var weight_label: Label = $Weight;
@onready var hair_label: Label = $Hair;
@onready var eyes_label: Label = $Eyes;
@onready var social_security_label: Label = $"Social Security";

var currentCharacter: character;

func update_id(person: character):
	currentCharacter = person;
	if(person.fake_information != null):
		name_label.text = person.fullName;
		
		if person.fake_information.dateOfBirth != null:
			date_of_birth_label.text = person.fake_information.dateOfBirth;
		else:
			date_of_birth_label.text = person.information.dateOfBirth;
		
		if person.fake_information.address != null:
			address_label.text = person.fake_information.address;
		else:
			address_label.text = person.information.address;
		
		if person.fake_information.height != null:
			height_label.text = person.fake_information.height;
		else:
			height_label.text = person.information.height;
		
		if person.fake_information.weight != null:
			height_label.text = person.fake_information.weight;
		else:
			height_label.text = person.information.weight;
		
		if person.fake_information.hair_color != null:
			height_label.text = person.fake_information.hair_color;
		else:
			height_label.text = person.information.hair_color;
		
		if person.fake_information.eye_color != null:
			height_label.text = person.fake_information.eye_color;
		else:
			height_label.text = person.information.eye_color;
		
		if person.fake_information.scocial_security != null:
			height_label.text = person.fake_information.scocial_security;
		else:
			height_label.text = person.information.scocial_security;
	else:
		name_label.text = person.fullName;
		date_of_birth_label.text = person.information.dateOfBirth;
		address_label.text = person.information.address;
		height_label.text = person.information.height;
		weight_label.text = person.information.weight;
		hair_label.text = person.information.hair_color;
		eyes_label.text = person.information.eye_color;
		social_security_label.text = person.information.scocial_security;
