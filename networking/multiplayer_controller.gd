extends Node
#class_name MultiplayerController

var tcp_server := TCPServer.new()

var sockets : Array[WebSocketPeer] = []

signal action_received(player : String, action : String, is_pressed : bool)

func _ready():
    var result := tcp_server.listen(Persistence.LISTEN_PORT)
    if result != OK:
        log_message("Unable to start server.")
        set_process(false)
    else:
        log_message("Server started at %s" % Persistence.LISTEN_PORT)

func log_message(message):
    var time = Time.get_time_string_from_system()
    prints('[server]', str(time), message)

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
    #prints("emit %s %s %s" % [player, action, is_pressed])
    # TODO choose between notifying methods bitteee, atm we use the second
    action_received.emit(player, action, is_pressed)
    get_tree().call_group('pics', 'external_input', player, action, is_pressed)

func _process(_delta):
    while tcp_server.is_connection_available():
        var conn: StreamPeerTCP = tcp_server.take_connection()
        assert(conn != null)
        var socket := WebSocketPeer.new()
        var result := socket.accept_stream(conn)
        log_message("start server %s" % error_string(result))
        sockets.push_back(socket)
        if result == Error.OK:
            socket.call_deferred('send_text','OK!')

    for socket in sockets:
        socket.poll()

        if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
            #socket.send_text('alive')
            while socket.get_available_packet_count():
                var message : String = socket.get_packet().get_string_from_ascii()
                log_message(message)
                process_packet(message)

func _exit_tree():
    for socket in sockets:
        socket.close()
    tcp_server.stop()

func _on_button_pong_pressed():
    for socket in sockets:
        socket.send_text("Pong")

