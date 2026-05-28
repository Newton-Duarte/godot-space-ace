class_name Shooter

extends Node2D

@export var shoot_scene: PackedScene
@export var shoot_wait: float = 3.0
@export var shoot_variance: float = 1.0
@export var shoot_sound: AudioStream

@onready var shoot_timer: Timer = $ShootTimer
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound

func _ready() -> void:
	restart_timer()
	launch_sound.stream = shoot_sound

func restart_timer() -> void:
	SpaceUtils.set_start_timer(shoot_timer, shoot_wait, shoot_variance)

func _on_shoot_timer_timeout() -> void:
	SignalHub.on_spawn_pool_object.emit(global_position, shoot_scene)
	launch_sound.play()
	restart_timer()
