extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer;

#scenes
const MAIN_MENU = preload("uid://cchdtcbqk4g67");
const ENDING = preload("uid://b8mtj3rpxrbsy");
const MAP_1 = preload("uid://b6251dnxi47nn");
const MAP_2 = preload("uid://bqicsvyt1jyfi");
const MAP_3 = preload("uid://douu8wiqx2leo");
const MAP_4 = preload("uid://d1cmyv5hwj2v7");
const MAP_5 = preload("uid://cnfqy4vlx1ywq");
const MAP_6 = preload("uid://db08f53r643vo");
const MAP_7 = preload("uid://delroofm52ubj");


func transition(scene: PackedScene) -> void:
	animation_player.play("transition");
	await(get_tree().create_timer(0.75).timeout);
	get_tree().change_scene_to_packed(scene);

func reload() -> void:
	animation_player.play("transition");
	await(get_tree().create_timer(0.75).timeout);
	get_tree().reload_current_scene();
