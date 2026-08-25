extends Node2D

func _ready() -> void:
	$volumeSlider.value = Globals.currentVolume

func _on_volume_slider_value_changed(value: float) -> void:
	Globals.currentVolume = value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), Globals.currentVolume)


func _on_test_volume_pressed() -> void:
	$testPlayer.play(6.7)
