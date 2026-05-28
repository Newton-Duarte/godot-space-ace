class_name ScenePool

extends RefCounted

const DEBUG_POOL: bool = true

var number_active: int:
	get:
		var active: int = 0
		for item in _items:
			if item.is_available: active += 1
		return active

var _items: Array[Poolable] = []
var _packed_scene: PackedScene
var _container: Node

func log_message(message: String) -> void:
	if DEBUG_POOL:
		print("[ScenePool:%s] %s" % [_packed_scene.resource_path, message])

func validate_scene() -> void:
	var test = _packed_scene.instantiate()
	var is_valid = test is Poolable
	test.free()
	assert(is_valid, "PackedScene root must extend Poolable: %s" % _packed_scene.resource_path)

func _init(initial_count: int, scene: PackedScene, container: Node) -> void:
	_container = container
	_packed_scene = scene
	
	validate_scene()
	
	log_message("Creating pool with %d items" % initial_count)
	
	for count in range(initial_count):
		add_new_item()

func add_new_item() -> Poolable:
	var new_item: Poolable = _packed_scene.instantiate()
	_container.add_child(new_item)
	_items.append(new_item)
	log_message("add_new_item() -> New Instance: {%s} :: {%d} total" % [
		new_item.name, _items.size()
	])
	return new_item

func activate_next(new_position: Vector2) -> void:
	log_message("activate_next() Available: {%d}/{%d} new_position{%v}" % [
		number_active, _items.size(), new_position
	])
	for item in _items:
		if item.is_available:
			item.global_position = new_position
			item.activate()
			return

	log_message("activate_next() needs new item")
	var new_item: Poolable = add_new_item()
	new_item.global_position = new_position
	new_item.activate()
