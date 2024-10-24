extends Node
class_name WsController

var tcp_server := TCPServer.new()
var socket := WebSocketPeer.new()

var socket2 := WebSocketPeer.new()

signal action_received(player : String, action : String, is_pressed : bool)

func log_message(message):
    var time = "[color=#aaaaaa] %s [/color]" % Time.get_time_string_from_system()
    prints('[server]' + time + message + "\n")

func process_packet(message):
    if len(message) > 100:
        prints('messasge too long')
        return
    var parsed = message.split('-')
    if len(parsed) != 3:
        prints('malformed message', parsed)
        return
    var player : String = parsed[0]
    var action : String = parsed[1]
    var is_pressed : bool = parsed[2] == '1'
    prints("emit %s %s %s" % [player, action, is_pressed])
    action_received.emit(player, action, is_pressed)

func _ready():
    var result := tcp_server.listen(Persistence.LISTEN_PORT)
    if result != OK:
        log_message("Unable to start server.")
        set_process(false)
    else:
        log_message("Server started at %s" % Persistence.LISTEN_PORT)

func _process(_delta):
    while tcp_server.is_connection_available():
        var conn: StreamPeerTCP = tcp_server.take_connection()
        assert(conn != null)
        var result = socket.accept_stream(conn)
        log_message("start server %s" % error_string(result))
        if result == Error.ERR_ALREADY_IN_USE:
            result = socket2.accept_stream(conn)
            log_message("start socket2 %s" % error_string(result))


    socket.poll()
    socket2.poll()

    if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
        #socket.send_text('alive')
        while socket.get_available_packet_count():
            var message : String = socket.get_packet().get_string_from_ascii()
            log_message(message)
            process_packet(message)

    if socket2.get_ready_state() == WebSocketPeer.STATE_OPEN:
        #socket.send_text('alive')
        while socket2.get_available_packet_count():
            var message2 : String = socket2.get_packet().get_string_from_ascii()
            log_message(message2)
            process_packet(message2)

func _exit_tree():
    socket.close()
    tcp_server.stop()

func _on_button_pong_pressed():
    socket.send_text("Pong")

