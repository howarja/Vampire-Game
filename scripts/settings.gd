extends Node2D

func _ready() -> void:
	$volumeSlider.value = Globals.currentVolume

func _on_volume_slider_value_changed(value: float) -> void:
	Globals.currentVolume = value
