extends Node
class_name SceneManager

var ip_address: String = "127.0.0.1"
var port: int = 8080


func _on_host_pressed() -> void:
	NetworkManager.active_network_type = NetworkManager.NETWORK_TYPES.ENET
	NetworkManager.host_lobby(ip_address, port)


func _on_join_pressed() -> void:
	NetworkManager.active_network_type = NetworkManager.NETWORK_TYPES.ENET
	NetworkManager.join_lobby_lan(ip_address, port)
