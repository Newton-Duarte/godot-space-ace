class_name TestPoolable

extends Node2D

static var count: int = 1

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func _ready() -> void:
	label.text = str(count)
	count += 1
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()
