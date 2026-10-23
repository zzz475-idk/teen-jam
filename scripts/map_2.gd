extends TileMapLayer

@onready var player: CharacterBody2D = $player;

func _on_spikes_area_body_entered(body: Node2D) -> void:
	if (body == player):
		Transition.reload();
