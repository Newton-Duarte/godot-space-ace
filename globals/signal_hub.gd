extends Node

signal on_spawn_pool_object(position: Vector2, scene: PackedScene)

func emit_on_spawn_pool_object(position: Vector2, scene: PackedScene) -> void:
	on_spawn_pool_object.emit(position, scene)
