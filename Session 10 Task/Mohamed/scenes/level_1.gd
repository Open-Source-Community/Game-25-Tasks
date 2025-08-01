extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var pac = load("res://scenes/level_2.tscn")
func switch_scene():
	get_tree().change_scene_to_packed(pac)


func _on_area_3d_body_entered(body: Node3D) -> void:
	switch_scene()
