extends Node

#region Network Types
enum NETWORK_TYPES {ENET, NORAY, STEAM}
var network_scenes: Dictionary[NETWORK_TYPES, PackedScene] = {
	NETWORK_TYPES.ENET: preload("uid://hpqa5s5qql7c"),
	NETWORK_TYPES.NORAY: preload("uid://bhkytwagujhib"),
	NETWORK_TYPES.STEAM: preload("uid://d1v5eelydl3rk")
}

var active_network_type: NETWORK_TYPES = NETWORK_TYPES.ENET
var active_network_node: Node
#endregion

#region Network Variables/Constants
const LOCALHOST: String = "127.0.0.1"
const DEFAULT_PORT: int = 8080

var is_host: bool = false
var connected_ip: String = LOCALHOST
var connected_port: int = DEFAULT_PORT
var connected_game_id: String = ""
#endregion

#region Build Network
func _reset_network() -> void:
	
	multiplayer.multiplayer_peer = null
	
	# Reset misc vars
	is_host = false
	connected_ip = ""
	connected_port = -1
	connected_game_id = "-1"
	
	if active_network_node:
		active_network_node.queue_free() # Remove the active network. It'll get rebuilt either way
	
	print_debug("All Network Vars and Nodes have been reset.")


func _build_network() -> void:
	_reset_network()
	
	if not active_network_node:
		active_network_node = network_scenes[active_network_type].instantiate()
		add_child(active_network_node)
	
#endregion


func host_lobby(ip_address: String = LOCALHOST, port: int = DEFAULT_PORT) -> void:
	_build_network() # NOTICE: Build network before anything else, as it resets our network vars
	
	print_debug("Hosting on port: ", port)
	
	# These are before the network is instantiated so we can use them in the network node if needed
	is_host = true
	connected_ip = ip_address
	connected_port = port
	
	var result: int = active_network_node.host_lobby(connected_ip, connected_port)
	if result == 0:
		print("Lobby is open!")
		_connect_multiplayer_signals()
		# Peer ID 1 is just the local player
		_on_peer_connected(1)
	
	else:
		_reset_network()
		push_error("Failed to host the game: ", result)


func join_lobby_lan(ip_address: String = LOCALHOST, port: int = DEFAULT_PORT) -> void:
	_build_network() # NOTICE: Build network before anything else, as it resets our network vars
	
	# These are before the network is instantiated so we can use them if needed
	connected_ip = ip_address
	connected_port = port
	
	var result: int = await active_network_node.join_lobby_lan(ip_address, port)
	if result == 0:
		_connect_multiplayer_signals()
	else:
		_reset_network()
		push_error("Failed to join the game.")


func join_lobby_code(code: String, ip_address: String = "") -> void:
	_build_network() # NOTICE: Build network before anything else, as it resets our network vars
	
	connected_game_id = code
	if ip_address:
		connected_ip = ip_address
	
	var result: int = active_network_node.join_lobby_code(connected_game_id, connected_ip)
	if result == 0:
		_connect_multiplayer_signals()
	else:
		_reset_network()
		push_error("Failed to join lobby code.")


func _connect_multiplayer_signals() -> void:
	if is_host:
		multiplayer.peer_connected.connect(_on_peer_connected)
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)


func _on_peer_connected(peer_id: int) -> void:
	print("Peer connected!")


func _on_peer_disconnected(peer_id: int) -> void:
	print("Peer disconnected!")
