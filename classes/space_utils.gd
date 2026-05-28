class_name SpaceUtils

static func set_start_timer(timer: Timer, wait_time: float, variance: float = 0.0) -> void:
	timer.start(wait_time + randf_range(-variance, variance))
