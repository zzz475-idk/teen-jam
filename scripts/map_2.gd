extends TileMapLayer

@onready var player: CharacterBody2D = $player;

func _on_spikes_area_body_entered(body: Node2D) -> void:
	if (body == player):
		Transition.reload();


func _on_exit_body_entered(body: Node2D) -> void:
	Transition.transition(Transition.MAP_3);
