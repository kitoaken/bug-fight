extends Node

var enet_network_peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()


func host_lobby(_ip_address: String, port: int) -> int:
	print_debug("Hosting on ENET. IP is LOCALHOST, Port is: ", port)
	var result: int = enet_network_peer.create_server(port)
	multiplayer.multiplayer_peer = enet_network_peer
	
	return result


func join_lobby_lan(ip_address: String, port: int) -> int:
	print_debug("Joining ENET/LAN Lobby, IP is: ", ip_address, ". Port is: ", port)
	var result: int = enet_network_peer.create_client(ip_address, port)
	multiplayer.multiplayer_peer = enet_network_peer
	
	return result


func join_lobby_code(_game_id: String, _ip_address: String) -> int:
	return ERR_UNCONFIGURED
