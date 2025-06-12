extends Label

func _ready() -> void:
	NetworkTime.on_tick.connect(_tick)

func _tick(_delta: float, _tick: int) -> void:
	
	text = "Time: %.2f at tick #%d" % [NetworkTime.time, NetworkTime.tick]

	if not get_tree().get_multiplayer().is_server():
		# Grab latency to server and display
		var enet: ENetMultiplayerPeer = get_tree().get_multiplayer().multiplayer_peer as ENetMultiplayerPeer
		if enet == null:
			return
			
		var server: ENetPacketPeer = enet.get_peer(1)
		var last_rtt: float = server.get_statistic(ENetPacketPeer.PEER_LAST_ROUND_TRIP_TIME)
		var last_variance: float = server.get_statistic(ENetPacketPeer.PEER_LAST_ROUND_TRIP_TIME_VARIANCE)
		var mean_rtt: float = server.get_statistic(ENetPacketPeer.PEER_ROUND_TRIP_TIME)
		var mean_variance: float = server.get_statistic(ENetPacketPeer.PEER_ROUND_TRIP_TIME_VARIANCE)

		text += "\nLast RTT: %s +/- %s\nMean RTT: %s +/- %s" % [last_rtt, last_variance, mean_rtt, mean_variance]
