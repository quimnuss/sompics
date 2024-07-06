extends Node


const DEF_PORT = 8080
const PROTO_NAME = "ludus"

var peer := WebSocketMultiplayerPeer.new()

signal peer_connected(id: int)
signal peer_disconnected(id: int)


func _init() -> void:
    peer.supported_protocols = ["ludus"]

func _on_Host_pressed() -> void:
    multiplayer.multiplayer_peer = null
    var result : Error = peer.create_server(DEF_PORT)
    print(result)

func _ready() -> void:
    multiplayer.peer_connected.connect(_peer_connected)
    multiplayer.peer_disconnected.connect(_peer_disconnected)
    multiplayer.server_disconnected.connect(_close_network)
    multiplayer.connection_failed.connect(_close_network)


func _peer_connected(id: int) -> void:
    print("Connected %d" % id)
    peer_connected.emit(id)


func _peer_disconnected(id: int) -> void:
    print("Disconnected %d" % id)
    peer_disconnected.emit(id)


func _close_network() -> void:
    #stop_game()
    print("Close network")
    multiplayer.multiplayer_peer = null
    peer.close()


func _on_button_pressed():
    _on_Host_pressed()
