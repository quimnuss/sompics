extends Node

## The URL we will connect to.
var websocket_url := "ws://localhost:" + str(Persistence.LISTEN_PORT)
var player : String = 'marta'
var socket : WebSocketPeer = WebSocketPeer.new()

func log_message(message: String) -> void:
    var time := "[color=#aaaaaa] %s |[/color] " % Time.get_time_string_from_system()
    %TextClient.text += time + message + "\n"


func _ready() -> void:
    if socket.connect_to_url(websocket_url) != OK:
        log_message("Unable to connect.")
        set_process(false)


func _process(_delta: float) -> void:
    socket.poll()

    if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
        while socket.get_available_packet_count():
            log_message(socket.get_packet().get_string_from_ascii())


func _exit_tree() -> void:
    socket.close()


func _on_button_ping_pressed() -> void:
    socket.send_text("Ping")


func _on_jump_button_down():
    socket.send_text(player + '-jump-1')


func _on_jump_button_up():
    socket.send_text(player + '-jump-0')


func _on_left_button_down():
    socket.send_text(player + '-move_left-1')


func _on_left_button_up():
    socket.send_text(player + '-move_left-0')


func _on_right_button_down():
    socket.send_text(player + '-move_right-1')


func _on_right_button_up():
    socket.send_text(player + '-move_right-0')
