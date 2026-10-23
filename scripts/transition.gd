extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer;

#scenes
const MAIN_MENU = preload("uid://cchdtcbqk4g67");
const MAP_1 = preload("uid://b6251dnxi47nn");
const MAP_2 = preload("uid://bqicsvyt1jyfi");


func transition(scene: PackedScene) -> void:
	animation_player.play("transition");
	await(get_tree().create_timer(0.75).timeout);
	get_tree().change_scene_to_packed(scene);
	
