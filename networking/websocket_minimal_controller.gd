extends Node
class_name WsController

# The port we will listen to.
const PORT = 9080
var tcp_server := TCPServer.new()
var socket := WebSocketPeer.new()

signal action_received(player : String, action : String, is_pressed : bool)

func log_message(message):
    var time = "[color=#aaaaaa] %s [/color]" % Time.get_time_string_from_system()
    prints('[server]' + time + message + "\n")

func process_packet(message):
    if len(message) > 100:
        prints('messasge too long')
        return
    var parsed = message.split('_')
    if len(parsed) != 3:
        prints('malformed message', parsed)
        return
    var player : String = parsed[0]
    var action : String = parsed[1]
    var is_pressed : bool = bool(parsed[2])
    action_received.emit(player, action, is_pressed)

func _ready():
    if tcp_server.listen(PORT) != OK:
        log_message("Unable to start server.")
        set_process(false)

func _process(_delta):
    while tcp_server.is_connection_available():
        var conn: StreamPeerTCP = tcp_server.take_connection()
        assert(conn != null)
        socket.accept_stream(conn)

    socket.poll()

    if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
        while socket.get_available_packet_count():
            var message : String = socket.get_packet().get_string_from_ascii()
            log_message(message)
            process_packet(message)

func _exit_tree():
    socket.close()
    tcp_server.stop()

func _on_button_pong_pressed():
    socket.send_text("Pong")

