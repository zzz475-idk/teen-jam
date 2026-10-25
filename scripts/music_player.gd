extends AudioStreamPlayer2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer;

func down() -> void:
	animation_player.play("down");
