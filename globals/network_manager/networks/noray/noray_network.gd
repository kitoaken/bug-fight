extends Node

var result: int = 0# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT
# RESULT IS TEMPORARY REMOVE IT


func _ready() -> void:
	setup_noray_connection_signals()

func setup_noray_connection_signals() -> void:
	if NetworkManager.is_host:
		pass
		#Noray.on_connect_nat.connect(_handle_noray_client_connect)
	else:
		pass

func host_lobby(ip_address: String, port: int) -> int:
	print_debug("Hosting Noray Lobby, IP is: ", ip_address, ". Port is: ", port)
	print_debug("Host lobby Noray: Review this print message above!")
	return result

func join_lobby_lan(_ip_address: String, _port: int) -> int:
	return ERR_UNCONFIGURED

func join_lobby_code(game_id: String, ip_address: String) -> int:
	print_debug("Joining Noray Lobby, Game ID is: ", game_id, ". IP is: ", ip_address)
	return result
