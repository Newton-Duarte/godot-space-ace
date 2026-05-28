class_name Projectile

extends Poolable

@onready var life_timer: Timer = $LifeTimer

var _mover: Mover

func _ready() -> void:
	for child in get_children():
		if child is Mover:
			_mover = child
			break
	assert(_mover, "No mover on base projectile")

func activate() -> void:
	super()
	_mover.setup_velocity()
	life_timer.start()

func _on_screen_exited() -> void:
	if visible:
		deactivate()

func _on_life_timer_timeout() -> void:
	deactivate()
