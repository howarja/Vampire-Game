extends Control


var currentFile
@onready var nameLabel: Label = $PhoneTexture/ScrollContainer/VBoxContainer/Name
@onready var date_of_birth: Label = $PhoneTexture/ScrollContainer/VBoxContainer/DateOfBirth
@onready var address: Label = $PhoneTexture/ScrollContainer/VBoxContainer/Address
@onready var bringing: Label = $PhoneTexture/ScrollContainer/VBoxContainer/Bringing
@onready var blood_type: Label = $PhoneTexture/ScrollContainer/VBoxContainer/BloodType
@onready var life_status: Label = $PhoneTexture/ScrollContainer/VBoxContainer/LifeStatus

func _ready() -> void:
	pass

func updatePhone(person: character):
	var currentFile = person
	nameLabel.text = person.fullName
	date_of_birth.text = person.information.dateOfBirth
	address.text = person.information.address
	bringing.text = person.information.bringing
	blood_type.text = person.information.bloodType
	life_status.text = person.information.lifeStatus
	
