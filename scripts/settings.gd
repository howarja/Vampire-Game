extends Node2D

var settingsVisible=false

func _ready() -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), $back/masterVolumeSlider.value)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), $back/musicVolumeSlider.value)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), $back/SFXVolumeSlider.value)


func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)

func _on_button_pressed() -> void:
	if(settingsVisible):
		settingsVisible=false
		$back.visible=false
		print("invisible!")
	else:
		settingsVisible=true
		$back.visible=true
