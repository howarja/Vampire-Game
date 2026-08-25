extends Node2D

func _ready() -> void:
	$masterVolumeSlider.value = 0.8
	$musicVolumeSlider.value = 1.0
	$SFXVolumeSlider.value = 1.0

func _on_test_volume_pressed() -> void:
	$testPlayer.play(6.7)

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)


func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
