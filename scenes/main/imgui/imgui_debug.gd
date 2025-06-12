extends Node

var current_choice: Array = [0]
var network_types: Array = NetworkManager.NETWORK_TYPES.keys()

var ip_address: Array = ["127.0.0.1"]
var port: Array = ["8080"]
var game_oid: Array = [""]

func _ready() -> void:
	# Remove Imgui in exported builds
	if !OS.has_feature("editor"):
		print("Not in Editor, deleting ImGui")
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.has_singleton("ImGuiAPI"):
		var ImGui: Object = Engine.get_singleton("ImGuiAPI")
		ImGui.Begin("Network Debugger", [], ImGui.WindowFlags_AlwaysAutoResize)
		
		ImGui.Combo("Network type", current_choice, network_types)
		
		ImGui.InputText("ip_address", ip_address, 32)
		ImGui.InputText("port", port, 8)
		
		if current_choice[0] == 1:
			ImGui.InputText("game_oid", game_oid, 32)
		
		if ImGui.Button("Host"):
			print("Hosting on port: ", int(port[0]))
			NetworkManager.active_network_type = current_choice[0]
			NetworkManager.host_lobby(ip_address[0], int(port[0]))
			pass
		
		if ImGui.Button("Join"):
			NetworkManager.active_network_type = current_choice[0]
			
			if current_choice[0] == NetworkManager.NETWORK_TYPES.ENET:
				NetworkManager.join_lobby_lan(ip_address[0], int(port[0]))
			else:
				NetworkManager.join_lobby_code(game_oid[0], ip_address[0])
			pass
		
		ImGui.End()
