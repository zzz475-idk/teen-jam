extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer;

func transition(scene: PackedScene) -> void:
	animation_player.play("transition");
	await(get_tree().create_timer(0.75).timeout);
	get_tree().change_scene_to_packed(scene);
	
